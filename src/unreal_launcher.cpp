#include "unreal_launcher.h"
#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <sys/wait.h>
#include <string>

// IMPORTANT: Define your absolute paths here
const std::string FEH_SCRIPT_PATH = "/home/leo/scripts/feh_foreground.sh";
const std::string UNREAL_APP_PATH = "/home/leo/UnrealProjects/MyGameProject/Binaries/Linux/MyGameProject";
const std::string PKILL_CMD = "/usr/bin/pkill -f \"feh\""; 

int launch_unreal_with_transition() {
    // 1. LAUNCH WHITE SCREEN (FEH)
    // ... (rest of the feh launch and 500ms usleep code) ...

    pid_t feh_wrapper_pid = fork();
    if (feh_wrapper_pid == 0) {
        // Child: Launch the script
        char* argv[] = {
            (char*)"/bin/sh", 
            (char*)FEH_SCRIPT_PATH.c_str(), 
            (char*)nullptr
        };
        execv("/bin/sh", argv);
        perror("execv (feh script)");
        _exit(1); 
    }
    usleep(500000); 

    // 2. LAUNCH UNREAL APPLICATION
    // ... (rest of the Unreal launch code) ...

    pid_t unreal_pid = fork();
    if (unreal_pid == 0) {
        // Child: Launch the Unreal executable
        char* argv[] = { (char*)UNREAL_APP_PATH.c_str(), (char*)nullptr };
        execv(UNREAL_APP_PATH.c_str(), argv); 
        perror("execv (Unreal app)");
        _exit(1);
    }
    
    // 3. PAUSE, CLEANUP FEH, AND WAIT FOR UNREAL APP TO EXIT
    std::cout << "Waiting 5 seconds for Unreal app to request focus..." << std::endl;
    sleep(5); 
    std::system(PKILL_CMD.c_str());

    int status;
    waitpid(unreal_pid, &status, 0); 

    // 4. FINAL CLEANUP
    kill(feh_wrapper_pid, SIGTERM);

    return WEXITSTATUS(status);
}