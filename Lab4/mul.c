#include<stdio.h>
int main()
{
	int a[][3]={1 , 2 ,3,4,5,6,7,8,9};
	int b[3][3];
	int c[3][3];
	int i , j , k ;
	for(  i = 0 ; i < 3 ; ++i )
	{
		for(  j = 0 ; j < 3 ; ++j )
		{
			b[i][j] = 0 ;
			for( k = 0 ; k < 3 ; ++k )
			{
				b[i][j] += a[i][k]*a[k][j] ;
			}
		}
	}
	for( i = 0 ; i < 3 ; ++i )
	{
		for( j = 0 ; j < 3 ; ++j )
		{
			c[i][j] = 0 ;
			for( k = 0 ; k < 3 ; ++k )
			{
				c[i][j] += a[i][k]*b[k][j] ;
			}
		}
	}

	for(  i = 0 ; i < 3 ; ++i )
	{
		for( j = 0 ; j < 3 ; ++j )
			printf("%d  ", b[i][j]);
	}
	printf("\n");
	for( i = 0 ; i < 3 ; ++i )
	{
		for( j = 0 ; j < 3 ; ++j )
			printf("%d  ", c[i][j]);
	}
	return 0;
}