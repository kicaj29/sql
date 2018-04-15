int __declspec(dllexport)calc_tax(int);

calc_tax(n)

int n;

{

int tax;

tax = (n*8)/100;

return(tax);

}
