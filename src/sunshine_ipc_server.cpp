#include "sunshine_ipc_server.h"
#include <iostream>
#include <cstring>
#include <string>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <thread>

#include "stream.h"

// --- GLOBAL DEFINITIONS (Storage for extern variables) ---


// The path for the Unix Domain Socket file
const char* SOCKET_PATH = "/tmp/sunshine_ipc.sock";
const int MAX_CONNECTIONS = 5;
const int BUFFER_SIZE = 256;

// --- IPC SERVER CORE LOGIC ---

void server_thread_function() {
    int listen_fd, client_fd;
    struct sockaddr_un server_addr;

    std::cout << "[IPC Thread] Starting dedicated Sunshine IPC Server..." << std::endl;
    
    // 1. Create the listening socket
    listen_fd = socket(AF_UNIX, SOCK_STREAM, 0);
    if (listen_fd == -1) {
        std::cerr << "[IPC Thread] Error: Failed to create socket." << std::endl;
        return; 
    }

    // 2. Clean up old socket file (CRUCIAL UDS STEP)
    // NOTE: This must be done with the path defined here.
    unlink(SOCKET_PATH); 

    // 3. Set up the server address structure
    std::memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sun_family = AF_UNIX;
    // Copy the path safely
    std::strncpy(server_addr.sun_path, SOCKET_PATH, sizeof(server_addr.sun_path) - 1);

    // 4. Bind the socket to the filesystem path
    if (bind(listen_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1) {
        std::cerr << "[IPC Thread] Error: Failed to bind socket." << std::endl;
        close(listen_fd);
        unlink(SOCKET_PATH);
        return; 
    }

    // 5. Start listening for connections
    if (listen(listen_fd, MAX_CONNECTIONS) == -1) {
        std::cerr << "[IPC Thread] Error: Failed to listen on socket." << std::endl;
        close(listen_fd);
        unlink(SOCKET_PATH);
        return; 
    }

    std::cout << "[IPC Thread] Server is listening for client connections at " << SOCKET_PATH << "..." << std::endl;

    // --- Main Server Loop (Accept and Handle Clients) ---
    while (true) {
        // 6. Wait for a client to connect
        client_fd = accept(listen_fd, NULL, NULL);
        if (client_fd == -1) {
            std::cerr << "[IPC Thread] Error: Failed to accept connection." << std::endl;
            continue; 
        }

        std::cout << "\n[IPC Thread] Unreal Engine Client connected." << std::endl;

        // --- Communication Loop ---
        char buffer[BUFFER_SIZE];
        ssize_t bytes_read;

        while ((bytes_read = recv(client_fd, buffer, BUFFER_SIZE - 1, 0)) > 0) {
            buffer[bytes_read] = '\0'; 
            std::cout << "[IPC Thread] Received from client: " << buffer << std::endl;
            
            // Check for the "Started" signal
            if (std::strcmp(buffer, "STARTED") == 0) {
                // SET THE GLOBAL FLAG FOR THE MAIN THREAD
                // We should usually break after receiving the critical signal
                break; 
            } else if (std::strcmp(buffer, "KEYBOARD") == 0) {
                // Handle show keyboard signal if needed
                std::cout << "[IPC Thread] Received Show keyboard signal to client." << std::endl;

                // Demo: trigger an existing Sunshine->Moonlight control event.
                if (stream::send_golfzon_event_keyboard(0, 255, 0, 0) == 0) {
                    std::cout << "[IPC Thread] Queued RGB LED event for active Moonlight session(s)." << std::endl;
                } else {
                    std::cout << "[IPC Thread] No active Moonlight session to receive RGB LED event." << std::endl;
                }
                break; 
            }
            
            // Send a response back
            std::string response = "ACK: Message received.";
            if (send(client_fd, response.c_str(), response.length(), MSG_NOSIGNAL) == -1) {
                std::cerr << "[IPC Thread] Error: Failed to send response." << std::endl;
                break;
            }
        }

        if (bytes_read == 0) {
            std::cout << "[IPC Thread] Client disconnected gracefully." << std::endl;
        } else if (bytes_read == -1) {
            std::cerr << "[IPC Thread] Error: Communication error." << std::endl;
        }

        close(client_fd);
    }

    close(listen_fd);
    unlink(SOCKET_PATH);
}

// Function to detach the server thread
void start_ipc_server() {
    // Check if the thread is already running or the socket exists before starting
    std::thread server_thread(server_thread_function);
    server_thread.detach();
}