clear all;
close all;

x=imread('#Image1 here');
y=imread('#Image2 here');

m=imresize(x,[256,256]);
n=imresize(y,[256,256]);

subplot(4,4,1)
imshow(m);
title('IMAGE1');
subplot(4,4,2)
imshow(n);
title('IMAGE2');
%addition
sum=m+n;
subplot(4,4,3)
imshow(sum);
title('SUM');
%subtraction
diff1=m-n;
subplot(4,4,4)
imshow(diff1);
title('SUBTRACTION1');
diff2=n-m;
subplot(4,4,5)
imshow(diff2);
title('SUBTRACTION2');

%performing multiplication 
multi=m.*n;
subplot(4,4,6)
imshow(multi);
title('MULTIPLICATION');

%performing division 
div1=m./n;
subplot(4,4,7)
imshow(div1);
title('DIVISION1');
div2=n./m;
subplot(4,4,8)
imshow(div2);
title('DIVISION2');

%logical AND
and=bitand(m,n);
subplot(4,4,9)
imshow(and);
title('LOGICAL AND');

%logical OR
or=bitor(m,n);
subplot(4,4,10)
imshow(or);
title('LOGICAL OR');

%logical NOT
not1=bitcmp(m);
subplot(4,4,11)
imshow(not1);
title('COMPLEMENT OF IMAGE1');
not2=bitcmp(n);
subplot(4,4,12)
imshow(not2);
title('COMPLEMENT OF IMAGE2');

%logical EX-OR
xor=bitxor(m,n);
subplot(4,4,13)
imshow(xor);
title('LOGICAL EX-OR');

%logical NAND
nand =bitcmp(and);
subplot(4,4,14)
imshow(nand);
title('LOGICAL NAND');

%logical NOR
nor=bitcmp(or);
subplot(4,4,15)
imshow(nor);
title('LOGICAL NOR');

%logical EX-NOR
xnor=bitcmp(xor);
subplot(4,4,16)
imshow(xnor);
title('LOGICAL EX-NOR');
