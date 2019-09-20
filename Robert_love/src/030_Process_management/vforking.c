#define _DEFAULT_SOURCE
#include <stdio.h>
#include <unistd.h>

#include <sys/types.h>

int main(void)
{
	pid_t forkStatus;
	
	printf("Before vfork.\n");
	forkStatus  = vfork();

	if(!forkStatus)
	{
		printf("Child!\n");
	}else if (forkStatus !=-1)
	{
		printf("Parent!\n");
	}else
	{
		printf("Error");
	}
	return 0;
}
