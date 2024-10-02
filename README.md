# Unity Build and Deploy Script for Itch.io

## Overview
This project was developed as a result of a technical challenge proposed by the **Agile Governance Research Lab (AGRLab)** during the selection process to join the research and innovation team. The challenge focused on creating a solution for automating build and deployment processes in game development.

This project provides a fully automated solution for building Unity projects and deploying them to Itch.io. It is designed to streamline the build process for developers working on Unity projects, reducing manual interventions and potential errors. The solution includes a **Bash script**, a **Batch script**, and a **Python script** that manage both the **build** and **deployment** processes. The available scripts allow seamless integration with multiple environments and platforms.

### Key Features:
- Automated multi-scene builds for Unity projects.
- Configurable build and deployment settings.
- WebGL build configuration for optimized output.
- Command-line interface with options for build-only, deploy-only, or both.
- Optional integration with Python for advanced automation.
- Compatible with Windows, Linux, and macOS.
  
## Automation release 
[Release demo list](https://github.com/brailog/UnityBuild-Deploy/wiki/Demonstration-release-list)

## Installation

### 1. Clone the Repository
Clone the repository to a local machine:
```bash
git clone https://github.com/your-username/unity-build-deploy.git
```

### 2. Used Tools 
- **Unity Editor**: Version `2022.3.48f1` (or compatible). [No dep with the automation script]
- **Butler CLI**: Used to upload builds to Itch.io. [https://itch.io/docs/butler/](https://itch.io/docs/butler/) [No need to install, buildin butler in the automation] 

### 3. Configure Environment Variables
Environment variables must be set for each script to define paths and project details. Below are the default configurations for each script:

#### **Batch Script (`.bat`) Configuration**:
```batch
set UNITY_PATH="/path/to/Unity/Editor/Unity"
set PROJECT_PATH="project-path"
set BUILD_PATH="Builds\DefaultWebGLBuild.zip"
set ITCHIO_USER="default-user"
set ITCHIO_GAME="default-game-name"
```

#### **Bash Script (`.sh`) underdevelopment **:
```bash
export UNITY_PATH="/path/to/Unity/Editor/Unity"
export PROJECT_PATH="project-path"
export BUILD_PATH="Builds/DefaultWebGLBuild.zip"
export ITCHIO_USER="default-user"
export ITCHIO_GAME="default-game-name"
```

#### **Python Script (`.py`) Configuration**:
```python
UNITY_PATH: str = "/path/to/Unity/Editor/Unity"
PROJECT_PATH: str = os.getcwd()
BUILD_PATH: str = "Builds/DefaultWebGLBuild.zip"
ITCHIO_USER: str = "default-user"
ITCHIO_GAME: str = "default-game-name"
```

Each path and variable is pre-configured with placeholder values that can be modified to match specific requirements.

### 4. Configure Scenes for Build and Integrate the Automation Script

The build process requires specifying which scenes from the Unity project will be included in the final build. This configuration can vary depending on the specific Unity project structure. To define the scenes, the script `BuildScript.cs` located in the `Assets/Editor` folder must be adjusted accordingly.

#### Steps for Configuring Scenes:

1. Open `BuildScript.cs` in the `Assets/Editor` directory. If the `Editor` folder or script does not exist, create the folder `Assets/Editor` manually and place the script inside.
2. Locate the `BuildWebGL` method inside `BuildScript.cs`.
3. Modify the `string[] scenes` array to include the scenes from your project that need to be built:

```csharp
string[] scenes = new[]
{
    "Assets/Scenes/Scene1.unity",    // Update with the correct paths to each scene in the Unity project
    "Assets/Scenes/Scene2.unity",
    "Assets/Scenes/Scene3.unity"
};
```
4. Ensure that each scene path listed in the scenes array is correct and exists within the Unity project. This setup is critical for a successful build.

### Why This Step is Important

This is the stage where the automation integrates with the Unity project. Having the `BuildScript.cs` in the `Assets/Editor` directory is essential because Unity recognizes scripts in this folder as part of the **Editor scripts**, allowing them to interact with the build pipeline. If `BuildScript.cs` is missing or located elsewhere, the build process will not work as expected.

**Tip**: The `Assets/Editor` folder is specific for Editor scripts that are not compiled into the final game build, making it the ideal place for build automation tools.

### If `BuildScript.cs` or the `Assets/Editor` Folder is Missing

- **Create the `Assets/Editor` Folder**: Manually create a folder named `Editor` inside the `Assets` directory.
- **Add `BuildScript.cs`**: Create a new script file named `BuildScript.cs` and paste the code into it.

After ensuring the scenes are configured and the script is correctly placed, proceed with executing the build using one of the supported scripts (`.bat`, `.sh`, or `.py`).

---
## Usage

### Executing the Scripts

Three different methods of execution are supported, depending on the operating system and preferred environment.

1. **Windows Batch Script** (`.bat`): Recommended for Windows users.
2. **Bash Script** (`.sh`): Recommended for Linux/macOS users or for execution in Git Bash on Windows.
3. **Python Script** (`.py`): Optional method for more flexibility and complex automation.

### Root Directory Execution
For all scripts, it is recommended to execute them from the **root directory** of the project to avoid path issues. Use the following commands:

## Command-Line Arguments
### Available Arguments:
- `--build`: Executes only the Unity build process.
- `--deploy`: Executes only the deployment process.
- No arguments: Runs both build and deploy processes sequentially.

#### **Batch Script** (`Windows`):
```bash
.\Pipeline\windows\pipeline_exe.bat --build   # Build only
.\Pipeline\windows\pipeline_exe.bat --deploy  # Deploy only
.\Pipeline\windows\pipeline_exe.bat           # Build and Deploy
```
#### **Bash Script** (`Linux/macOS`):
```bash
./Pipeline/unix/pipeline_exe.sh --build   # Build only
./Pipeline/linux/pipeline_exe.sh --deploy  # Deploy only
./Pipeline/linux/pipeline_exe.sh           # Build and Deploy

```

#### **Python Script** (Cross-platform):
```bash
python Pipeline/univ_pipeline.py --build   # Build only
python Pipeline/univ_pipeline.py --deploy  # Deploy only
python Pipeline/univ_pipeline.py           # Build and Deploy
```

#### Python as an Optional Dependency

The Python script is provided as an **optional dependency** for users who prefer to use Python for automation and for cross-platform compatibility. Python offers greater flexibility and can be integrated into more complex build pipelines.

## Authors
Developed by Gabriel Ramos for the Agile Governance Research Lab (AGRLab) challenger.
For any questions or issues, feel free to reach out or open an issue on GitHub!
