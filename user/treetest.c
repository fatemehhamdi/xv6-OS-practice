#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(void) {
    int worker_pid;
    int p[2];

    if(pipe(p) < 0){
        printf("pipe failed\n");
        exit(1);
    }

    printf("simpletest: Creating a worker child and synchronizing with a pipe.\n");

    worker_pid = fork();

    if(worker_pid < 0){
        printf("fork failed\n");
        exit(1);
    }

    if(worker_pid == 0){
        close(p[0]); 

        printf("worker (%d): I am alive. Signaling parent through pipe...\n", getpid());
        
        write(p[1], "a", 1); 
        close(p[1]);

        for(volatile int i = 0; i < 90000000; i++); 
        
        printf("worker (%d): Work done. Exiting.\n", getpid());
        exit(0);
    } else {
        close(p[1]);

        char buf[1];
        read(p[0], buf, 1);
        close(p[0]);

        printf("parent (%d): Signal received from worker. Now running 'top --tree'.\n\n", getpid());

        int top_pid = fork();
        if(top_pid == 0){
            char *argv[] = {"top", "--tree", 0};
            exec("top", argv);
            printf("exec top failed!\n"); 
            exit(1);
        }

        wait(0);
        wait(0);

        printf("\nparent (%d): Test complete.\n", getpid());
    }

    exit(0);
}
