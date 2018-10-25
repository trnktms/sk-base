using module ".\helpers\config-helper.psm1";
using module ".\helpers\file-helper.psm1";
using module ".\helpers\log-helper.psm1";
using module ".\helpers\settings.psm1";

Param(
    [Parameter(Mandatory = $true)] [string]$moduleName,
    [Parameter(Mandatory = $true)] [string]$subProjectName,
    [Parameter(Mandatory = $true)] [string]$templateName,
    [Parameter(Mandatory = $false)] [string]$targetPath,
    [Parameter(Mandatory = $false)] [string]$configPath,
    [Parameter(Mandatory = $false)] [string]$templatePath,
    [Parameter(Mandatory = $false)] [bool]$toRoot)

if ([string]::IsNullOrEmpty($targetPath)) {
    if ($toRoot) {
        $targetPath = [Settings]::RootTargetDir();
    } else {
        $targetPath = [Settings]::DefaultTargetDir();
    }
}

if ([string]::IsNullOrEmpty($configPath)) {
    $configPath = Join-Path ([Settings]::ConfigsDir()) -ChildPath "default.config.json";
}

if ([string]::IsNullOrEmpty($templatePath)) {
    $templatePath = Join-Path -Path ([Settings]::TemplatesAddModuleDir()) -ChildPath $templateName;
}

# deserialiaze JSON config
$config = (Get-Content $configPath) -join "`n" | ConvertFrom-Json

# logo
[LogHelper]::Logo();

# copy to queue
[LogHelper]::Info("Copy to queue...");
Get-ChildItem -Path $templatePath | Copy-Item -Destination ([Settings]::QueueDir()) -Recurse;

# files
$files = Get-ChildItem -Path ([Settings]::QueueDir()) -File -Recurse -Exclude *.dll, *.pdb, *.xml;

# replace content in files
[LogHelper]::Info("Setup content in files...");
[FileHelper]::ReplaceContent($files, [Settings]::Sk_projectName(), $config.projectName, $null);
[FileHelper]::ReplaceContent($files, [Settings]::Sk_subProjectName(), $subProjectName, $null);
[FileHelper]::ReplaceContent($files, [Settings]::Sk_moduleName(), $moduleName, $null);

[ConfigHelper]::IterateOnObjectProperties($config, $files);

# rename files
[LogHelper]::Info("Rename files...");
[FileHelper]::RenameFiles($files, $config.projectName, [Settings]::Sk_projectName());

$files = Get-ChildItem -Path ([Settings]::QueueDir()) -File -Recurse -Exclude *.dll, *.pdb, *.xml;
[FileHelper]::RenameFiles($files, $subProjectName, [Settings]::Sk_subProjectName());

$files = Get-ChildItem -Path ([Settings]::QueueDir()) -File -Recurse -Exclude *.dll, *.pdb, *.xml;
[FileHelper]::RenameFiles($files, $moduleName, [Settings]::Sk_moduleName());

# folders
$dirs = Get-ChildItem -Path ([Settings]::QueueDir()) -Directory -Recurse;

# rename dirs
[LogHelper]::Info("Rename unicorn directories...");
[FileHelper]::RenameDirs([Settings]::Root(), $dirs, $config.projectName, [Settings]::Sk_projectName());

$dirs = Get-ChildItem -Path ([Settings]::QueueDir()) -Directory -Recurse;
[FileHelper]::RenameDirs([Settings]::Root(), $dirs, $subProjectName, [Settings]::Sk_subProjectName());

$dirs = Get-ChildItem -Path ([Settings]::QueueDir()) -Directory -Recurse;
[FileHelper]::RenameDirs([Settings]::Root(), $dirs, $moduleName, [Settings]::Sk_moduleName());

# copy to target
[LogHelper]::Info("Copy to target...");
Get-ChildItem -Path ([Settings]::QueueDir()) | Copy-Item -Destination $targetPath -Recurse -Force;

# clean up queue
[LogHelper]::Info("Clean up queue...")
Get-ChildItem -Path ([Settings]::QueueDir()) | Remove-Item -Recurse

[LogHelper]::InfoDark("DONE!")