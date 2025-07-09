# Windows Execution Architecture

Before diving into hooking, it’s critical to understand that Windows has a layered architecture:

### User Mode: Where standard applications run. It has limited access to system resources.

### Kernel Mode: The core of the OS (the Windows Kernel) and device drivers. It has unrestricted access.

Hooking can occur at either level depending on the goal: observation, enforcement, blocking, or redirection.

