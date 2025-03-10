# project-navigation-script-shell

A Bash script for quickly navigating to and opening directories in VS Code.

# Dash Script for Quick Directory Navigation

This Bash script, `dash.sh`, provides a convenient way to quickly navigate to and open specific directories in VS Code. It is designed for developers who frequently work with multiple projects or services within a larger codebase.

## Benefits

* **Fast Navigation:** Quickly switch between directories without manually typing long paths.
* **VS Code Integration:** Opens the selected directory directly in VS Code.
* **Interactive Mode:** Provides a menu-driven interface for easy selection.
* **Multiple Directory Support:** Open multiple directories at once.
* **Open All Option:** Open all directories defined in the script with a single command.
* **Exit Option:** Exit the script easily.

## Clone and Setup

1.  **Clone the Repository:**
    * Open your terminal and navigate to the directory where you want to store the script.
    * Run the following command to clone the repository:
        ```bash
        git clone https://github.com/EngMustafaSabah/project-navigation-script-shell.git
        ```
2.  **Navigate to the Directory:**
    * Change your current directory to the cloned repository:
        ```bash
        cd project-navigation-script-shell
        ```
3.  **Make Executable:**
    * Run the following command to make the script executable:
        ```bash
        chmod +x dash.sh
        ```
4.  **Configure Directory Paths:**
    * Open `dash.sh` in a text editor.
    * Modify the `dirs` array to include the names of the directories you want to navigate to.
        * Example:
            ```bash
            dirs=(
              backend
              frontend
              documentation
            )
            ```
    * Change the `full_path="/mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/$dir"` line to reflect the base path of your projects. Replace `/mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/` with your base path.
5.  **Add to PATH (Optional):**
    * To run the script from any directory, you can add it to your `PATH` environment variable.
    * Move `dash.sh` to a directory in your `PATH` (e.g., `/usr/local/bin`).
    * Or, add the script's directory to your `PATH` in your `.bashrc` or `.zshrc` file:
        ```bash
        export PATH="$PATH:/path/to/your/dash/directory"
        ```
        * Then run `source ~/.bashrc` or `source ~/.zshrc` to apply the changes.

## Usage

### Interactive Mode

* Run the script without any arguments:
    ```bash
    ./dash.sh
    ```
* A menu will appear, listing the available directories.
* Enter the number corresponding to the directory you want to open.
* You can enter multiple numbers separated by spaces to open multiple directories.
* Enter `*` to open all directories.
* Enter `0` to exit the script. **Note:** This will close the shell process, but may not close the terminal window itself, depending on your terminal emulator.

### Command-Line Arguments

* **Open a specific directory:**
    ```bash
    ./dash.sh --go <number>
    ```
    * Replace `<number>` with the number of the directory from the `dirs` array.
* **Open multiple directories:**
    ```bash
    ./dash.sh --go <number1> <number2> ...
    ```
* **Open all directories:**
    ```bash
    ./dash.sh --go "*"
    ```

## Dependencies

* **Bash:** The script is written in Bash, so it should work on most Linux and macOS systems.
* **VS Code:** The script uses the `code` command to open directories in VS Code. Make sure VS Code is installed and the `code` command is in your `PATH`.

## Notes

* This script assumes that the directories specified in the `dirs` array exist at the specified base path.
* If you encounter issues with the `code` command, ensure that VS Code is properly installed and configured.
* The `exit 0` function closes the shell process, but might not close the terminal window itself. This is operating system and terminal emulator dependent.
