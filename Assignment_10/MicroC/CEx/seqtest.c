void main (int n)
{
    int i;
    i = n;
    int j;
    j = 10;
    if (0<i && j<i)         // i is a positive int greater than 10
    {
        print 1111;
    }
    
    if (0<i || j<i)        // i is a positive int and it might be greater than 10 
    {
        print 2222;
    }
}