#define LOG_TAG "setaddr32"

#include <stdio.h>
#include <stdlib.h>
#include <sys/personality.h>
#include <unistd.h>

int main( int argc, char ** argv)
{
	if ( argc < 2 )
	{
		return -1;
	}
	personality( 0x10000000);
	return execvp( argv[1], argv + 1);
}
