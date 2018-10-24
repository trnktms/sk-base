# settings
$sk_projectName = "[projectName]"
$sk_subProjectName = "[subProjectName]"
$sk_moduleName = "[moduleName]"

# sk paths
$scriptsRoot = Split-Path -Parent $PSScriptRoot
$root = Split-Path -Parent $scriptsRoot
$extensionRoot = Split-Path -Parent $root
<<<<<<< HEAD
=======
$rootTargetDir = Split-Path -Parent $extensionRoot
>>>>>>> 8faff68d2d6a823c01255731c9dfe6b82986e07a
$templatesDir = Join-Path -Path $extensionRoot -ChildPath "sk-templates"
$queueDir = Join-Path -Path $root -ChildPath "sk-queue"
$templatesAddModuleDir = Join-Path -Path $templatesDir -ChildPath "add-module"
$templatesAddProjectDir = Join-Path -Path $templatesDir -ChildPath "add-project"
$templatesInitDir = Join-Path -Path $templatesDir -ChildPath "init"
$configsDir = Join-Path -Path $extensionRoot -ChildPath "sk-configs"
$defaultTargetDir = Join-Path -Path $extensionRoot -ChildPath "target"