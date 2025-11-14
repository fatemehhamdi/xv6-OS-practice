#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main() {
    printf("PID\tCommand\t\t Size of Process Memory\n");
    top();
    exit(0);
}
