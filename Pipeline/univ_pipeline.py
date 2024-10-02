import os
import logging
import argparse
import subprocess

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

UNITY_PATH: str = "C:/Program Files/Unity/Hub/Editor/2022.3.48f1/Editor/Unity.exe"
PROJECT_PATH: str = os.getcwd()
BUILD_PATH: str = "Builds/WebGLBuild.zip"
ITCHIO_USER: str = "brailog"
ITCHIO_GAME: str = "agrlab-grro-demo1"
BUTLER_WIN_EXEC: str = "./Resource/butler_exe/butler"

def parse_arguments() -> argparse.Namespace:
    """
    Configure the argument parser and return parsed arguments.
    
    :return: Parsed arguments.
    """
    parser = argparse.ArgumentParser(
        description="Build and Deploy Script for Unity and Itch.io."
    )
    parser.add_argument("--build", action="store_true", help="Executes only the build process.")
    parser.add_argument("--deploy", action="store_true", help="Executes only the deploy process.")
    return parser.parse_args()


def run_build(unity_path: str, project_path: str, build_script: str = "Build") -> None:
    """
    Execute the Unity build process.

    :param unity_path: Path to the Unity Editor executable.
    :param project_path: Path to the Unity project directory.
    :param build_script: Name of the Unity build script method to execute.
    """
    logger.info("Starting Unity Build Process...")
    unity_cmd = [
        unity_path,
        "-quit",
        "-batchmode",
        f"-projectPath={project_path}",
        "-executeMethod",
        f"Builder.{build_script}"
    ]
    logger.debug("Executing command: %s", " ".join(unity_cmd))
    subprocess.run(unity_cmd, check=True)
    logger.info("Unity Build Completed!")


def run_deploy(build_path: str, itchio_user: str, itchio_game: str) -> None:
    """
    Execute the Itch.io deploy process.

    :param build_path: Path to the WebGL build file to be deployed.
    :param itchio_user: Itch.io username.
    :param itchio_game: Itch.io game project name.
    """
    logger.info("Starting Itch.io Deploy Process...")
    deploy_cmd = [BUTLER_WIN_EXEC, "push", build_path, f"{itchio_user}/{itchio_game}:webgl"]
    logger.debug("Executing command: %s", " ".join(deploy_cmd))
    subprocess.run(deploy_cmd, check=True)
    logger.info("Itch.io Deploy Completed!")


def main() -> None:
    """
    Execute build, deploy, or both based on the provided arguments.
    """
    args = parse_arguments()

    execute_build: bool = args.build or not args.deploy
    execute_deploy: bool = args.deploy or not args.build

    if execute_build:
        run_build(UNITY_PATH, PROJECT_PATH)

    if execute_deploy:
        run_deploy(BUILD_PATH, ITCHIO_USER, ITCHIO_GAME)


if __name__ == "__main__":
    main()
