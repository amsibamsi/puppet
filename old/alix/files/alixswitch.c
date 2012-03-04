// Managed by Puppet

#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>
#include <machine/cpufunc.h>

u_int32_t switchAddr = 0x61b0;
int switchBit = 8;

char isPressed() {
  return ((inl(switchAddr) & (1 << switchBit)) == 0);
}

int main() {
  int fd;
  char *empty_environ[] = { NULL };

  if(geteuid()) {
    errx(1, "Must be super-user");
  }

  fd = open("/dev/io", O_RDONLY);

  if (fd == -1) {
    perror("Cannot open /dev/io");
    exit(1);
  }

  while(1) {
    usleep(2000000);
    if(isPressed()) {
      exit(0);
    }
  }
}
