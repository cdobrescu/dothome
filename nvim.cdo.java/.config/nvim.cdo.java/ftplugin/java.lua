local jdtls = require("jdtls")

-- 1. Helper function for OS detection
local function get_config_dir()
  if vim.fn.has("mac") == 1 then
    return "config_mac"
  elseif vim.fn.has("win32") == 1 then
    return "config_win"
  else
    return "config_linux"
  end
end

-- 2. Determine root directory & project workspace name
local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
if not root_dir or root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java-workspace/" .. project_name

-- 3. Mason installation paths
local mason_registry = require("mason-registry")
local jdtls_pkg = mason_registry.get_package("jdtls")
local jdtls_path = jdtls_pkg:get_install_path()

local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local config_dir = jdtls_path .. "/" .. get_config_dir()
local lombok_jar = jdtls_path .. "/lombok.jar"

-- 4. DAP Debugger and Test Runner bundles
local bundles = {}
if mason_registry.has_package("java-debug-adapter") then
  local java_debug_pkg = mason_registry.get_package("java-debug-adapter")
  local java_debug_path = java_debug_pkg:get_install_path()
  local jar_pattern = java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"
  local bundle = vim.fn.glob(jar_pattern, true)
  if bundle ~= "" then
    table.insert(bundles, bundle)
  end
end

if mason_registry.has_package("java-test") then
  local java_test_pkg = mason_registry.get_package("java-test")
  local java_test_path = java_test_pkg:get_install_path()
  local test_jars = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true, true)
  for _, jar in ipairs(test_jars) do
    table.insert(bundles, jar)
  end
end

-- 5. Extended LSP capabilities with nvim-cmp integration
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- 6. JDTLS Command Line Configuration
local cmd = {
  "java",
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-DOSGI_BUNDLE_SPLIT=error",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.level=ALL",
  "-Xmx1g",
  "--add-modules=ALL-SYSTEM",
  "--add-opens", "java.base/java.util=ALL-UNNAMED",
  "--add-opens", "java.base/java.lang=ALL-UNNAMED",

  -- Lombok support
  "-javaagent:" .. lombok_jar,

  "-jar", launcher_jar,
  "-configuration", config_dir,
  "-data", workspace_dir,
}

-- 7. JDTLS Settings
local settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" }, -- Decompiler preference
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
    -- Configure Runtimes for Multi-JDK projects if needed
    configuration = {
      runtimes = {
        -- Example of specifying multiple JDK installations:
        -- { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk/" },
        -- { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk/" },
        -- { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk/" },
      },
    },
  },
}

-- 8. On Attach callback for Keymaps & DAP initialization
local on_attach = function(client, bufnr)
  -- Initialize Debugging & Testing Capabilities
  jdtls.setup_dap({ hotcodereplace = "auto" })
  jdtls.setup.add_commands()

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- Standard LSP Mappings
  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "gr", require("telescope.builtin").lsp_references, "Go to References")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

  -- Java Specific Refactoring & Commands
  map("n", "<leader>co", jdtls.organize_imports, "Organize Imports")
  map("n", "<leader>ev", jdtls.extract_variable, "Extract Variable")
  map("v", "<leader>ev", function() jdtls.extract_variable(true) end, "Extract Variable (Selection)")
  map("n", "<leader>ec", jdtls.extract_constant, "Extract Constant")
  map("v", "<leader>ec", function() jdtls.extract_constant(true) end, "Extract Constant (Selection)")
  map("v", "<leader>em", function() jdtls.extract_method(true) end, "Extract Method")
  map("n", "<leader>tc", jdtls.test_class, "Test Class")
  map("n", "<leader>tm", jdtls.test_nearest_method, "Test Nearest Method")
end

-- 9. Start or attach JDTLS
jdtls.start_or_attach({
  cmd = cmd,
  root_dir = root_dir,
  settings = settings,
  capabilities = capabilities,
  extendedClientCapabilities = extendedClientCapabilities,
  init_options = {
    bundles = bundles,
  },
  on_attach = on_attach,
})

