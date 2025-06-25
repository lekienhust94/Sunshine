// #include "sunshine_ipc_server.h" 

// // --- C++ Standard Libraries ---
// #include <iostream>     // For std::cout, std::cerr
// #include <string>       // For std::string
// #include <cstring>      // For memset(), strncpy()
// #include <thread>       // For std::thread, std::thread::detach()

// const char* SOCKET_PATH = "/tmp/sunshine_ipc.sock";
// const int BUFFER_SIZE = 1024;
// const int MAX_CONNECTIONS = 5; 


// /**
//  * @brief The internal function that runs the server loop.
//  * This is the function that runs in the dedicated background thread.
//  */
// void server_thread_function() {
//     int listen_fd, client_fd;
//     struct sockaddr_un server_addr;

//     std::cout << "[IPC Thread] Starting Sunshine IPC Server..." << std::endl;
    
//     // 1. Create the listening socket
//     listen_fd = socket(AF_UNIX, SOCK_STREAM, 0);
//     if (listen_fd == -1) {
//         std::cerr << "[IPC Thread] Error: Failed to create socket." << std::endl;
//         return; 
//     }

//     // 2. Clean up old socket file (CRUCIAL UDS STEP)
//     unlink(SOCKET_PATH);

//     // 3. Set up the server address structure
//     std::memset(&server_addr, 0, sizeof(server_addr));
//     server_addr.sun_family = AF_UNIX;
//     std::strncpy(server_addr.sun_path, SOCKET_PATH, sizeof(server_addr.sun_path) - 1);

//     // 4. Bind the socket to the filesystem path
//     if (bind(listen_fd, (struct sockaddr*)&server_addr, sizeof(server_addr)) == -1) {
//         std::cerr << "[IPC Thread] Error: Failed to bind socket." << std::endl;
//         close(listen_fd);
//         unlink(SOCKET_PATH);
//         return; 
//     }

//     // 5. Start listening for connections
//     if (listen(listen_fd, MAX_CONNECTIONS) == -1) {
//         std::cerr << "[IPC Thread] Error: Failed to listen on socket." << std::endl;
//         close(listen_fd);
//         unlink(SOCKET_PATH);
//         return; 
//     }

//     std::cout << "[IPC Thread] Server is listening for client connections..." << std::endl;

//     // --- Main Server Loop (Accept and Handle Clients) ---
//     while (true) {
//         // 6. Wait for a client to connect (BLOCKS THIS THREAD ONLY)
//         client_fd = accept(listen_fd, NULL, NULL);
//         if (client_fd == -1) {
//             std::cerr << "[IPC Thread] Error: Failed to accept connection." << std::endl;
//             continue; 
//         }

//         std::cout << "\n[IPC Thread] Unreal Engine Client connected." << std::endl;

//         // --- Communication Loop (Talking to the specific client) ---
//         char buffer[BUFFER_SIZE];
//         ssize_t bytes_read;

//         while ((bytes_read = recv(client_fd, buffer, BUFFER_SIZE - 1, 0)) > 0) {
//             buffer[bytes_read] = '\0'; 
//             std::cout << "[IPC Thread] Received from client: " << buffer << std::endl;

//             // Send a response back
//             std::string response = "ACK: Message received.";
//             if (send(client_fd, response.c_str(), response.length(), 0) == -1) {
//                 std::cerr << "[IPC Thread] Error: Failed to send response." << std::endl;
//                 break;
//             }
//         }

//         if (bytes_read == 0) {
//             std::cout << "[IPC Thread] Client disconnected gracefully." << std::endl;
//         } else if (bytes_read == -1) {
//             std::cerr << "[IPC Thread] Error: Communication error." << std::endl;
//         }

//         close(client_fd);
//     }

//     close(listen_fd);
//     unlink(SOCKET_PATH);
// }


// void start_ipc_server() {
//     std::thread server_thread(server_thread_function);

//     server_thread.detach();
// }
