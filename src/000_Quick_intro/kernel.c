/*
* kernel.c
*/

void kmain(void)
{
	const char *str = "Some text to print";
	char *vidptr = (char*)(0xb8000); 	//video memory begins here
	unsigned int i = 0,
		     j = 0;

	/* this loop clears the screen
	* there are 25 lines each of 80 columns. each element takes 2 bytes */
	while(j < 80 * 25 * 2) 
	{
		/* blank character */
		vidptr[j] = ' ';
		/* attribute-byte light greay on black screen */
		vidptr[j+1] = 0x07;
		j+=2;
	}

	j = 0;

	/* this loop writes the string to video memory*/
	while(str[j]!='\0')
	{
		/* iterate through string*/
		vidptr[i] = str[i];
		/* attribute-byte: given character black bg and green fg*/
		vidptr[i+1] = 0x02;
		j++;
		i +=2;
	}

	return;
}
