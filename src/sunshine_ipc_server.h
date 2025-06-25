#ifndef SUNSHINE_IPC_SERVER_H
#define SUNSHINE_IPC_SERVER_H

#include <atomic>

// --- SHARED GLOBALS ---

// Flag set by the IPC server thread when the Unreal App sends the "Started" message.
// Use std::atomic for thread-safe access from the IPC thread and the main HTTP thread.

// Define the socket path constant (must be declared extern here)
extern const char* SOCKET_PATH;
extern const int MAX_CONNECTIONS;
extern const int BUFFER_SIZE;

// --- FUNCTIONS ---

// Function containing the core server loop logic (now defined in ipc_server.cpp)
void server_thread_function();

// Function called by launch.cpp to start the IPC server thread
void start_ipc_server();

#endif // SUNSHINE_IPC_SERVER_H