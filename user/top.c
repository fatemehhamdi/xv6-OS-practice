#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

#define MAX_PROCS 64

void itoa(int n, char *buf) {
  char temp[12];
  int i = 0;
  if (n == 0) {
    buf[0] = '0';
    buf[1] = '\0';
    return;
  }
  while (n > 0) {
    temp[i++] = (n % 10) + '0';
    n /= 10;
  }
  int j = 0;
  while (i > 0) {
    buf[j++] = temp[--i];
  }
  buf[j] = '\0';
}

void uitoa64(uint64 n, char *buf) {
  char temp[21];
  int i = 0;
  if (n == 0) {
    buf[0] = '0';
    buf[1] = '\0';
    return;
  }
  while (n > 0) {
    temp[i++] = (n % 10) + '0';
    n /= 10;
  }
  int j = 0;
  while (i > 0) {
    buf[j++] = temp[--i];
  }
  buf[j] = '\0';
}


const char*
get_state_str(enum procstate state) {
  static const char *states[] = {
    [UNUSED]   "Unused",   [USED]   "Used",
    [SLEEPING] "Sleeping", [RUNNABLE] "Runnable",
    [RUNNING]  "Running",  [ZOMBIE]   "Zombie"
  };
  if (state >= 0 && state < sizeof(states)/sizeof(states[0]))
    return states[state];
  return "???";
}

void run_top_list() {
  struct process_data all_procs[MAX_PROCS];
  int count = 0;
  int last_pid = -1;

  while (count < MAX_PROCS) {
    int next_pid = next_process(last_pid, &all_procs[count]);
    if (next_pid == 0) break;
    last_pid = next_pid;
    count++;
  }

  printf("PID\tPPID\tSTATE\t\tSIZE\t\tNAME\n");
  printf("----------------------------------------------------------\n");
  
  for (int i = 0; i < count; i++) {
    char pid_buf[12], ppid_buf[12], size_buf[21];
    
    itoa(all_procs[i].pid, pid_buf);
    itoa(all_procs[i].parent_id, ppid_buf);
    uitoa64(all_procs[i].size, size_buf);
    
    const char* state_str = get_state_str(all_procs[i].state);
    
    printf("%s\t%s\t%s", pid_buf, ppid_buf, state_str);
    
    if (strlen(state_str) < 8) {
      printf("\t\t");
    } else {
      printf("\t");
    }
    
    printf("%s\t\t%s\n", size_buf, all_procs[i].name);
  }
}

void print_tree(struct process_data procs[], int count, int parent_pid, int depth) {
  for (int i = 0; i < count; i++) {
    if (procs[i].parent_id == parent_pid && procs[i].pid != parent_pid) {
      for (int d = 0; d < depth; d++) {
        printf("  ");
      }
      printf("|- %d (%s, %s)\n", procs[i].pid, procs[i].name, get_state_str(procs[i].state));
      print_tree(procs, count, procs[i].pid, depth + 1);
    }
  }
}

void run_top_tree() {
  struct process_data all_procs[MAX_PROCS];
  int count = 0;
  int last_pid = -1;

  while (count < MAX_PROCS) {
    int next_pid = next_process(last_pid, &all_procs[count]);
    if (next_pid == 0) break;
    last_pid = next_pid;
    count++;
  }
  
  printf("Process Tree:\n");
  
  for(int i = 0; i < count; i++){
    if(all_procs[i].pid == 1){
      printf("%d (%s, %s)\n", all_procs[i].pid, all_procs[i].name, get_state_str(all_procs[i].state));
      print_tree(all_procs, count, 1, 0); 
      break;
    }
  }
}

int main(int argc, char *argv[]) {
  int tree_mode = 0;
  if (argc > 1) {
    if (strcmp(argv[1], "-t") == 0 || strcmp(argv[1], "--tree") == 0) {
      tree_mode = 1;
    }
  }

  if (tree_mode) {
    run_top_tree();
  } else {
    run_top_list();
  }

  exit(0);
}
