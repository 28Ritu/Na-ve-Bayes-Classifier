%%
% Name: Ritu Kumari     Roll No.: 2016078
filename='car.data.txt';
G=readtable(filename, 'Delimiter', ',');
A1=table2array(G(:, 1:6));
D=table2array(G(:, 7));
A=zeros(1727,6);
for i=1:1727
    for j=1:6
        if (strcmp(A1(i,j),'vhigh')==1 && (i==1 || i==2))
           A(i,j)=1;
        end
        if (strcmp(A1(i,j),'high')==1 && (i==1 || i==2))
           A(i,j)=2;
        end
        if (strcmp(A1(i,j),'med')==1 && (i==1 || i==2))
           A(i,j)=3;
        end
        if (strcmp(A1(i,j),'low')==1 && (i==1 || i==2))
           A(i,j)=4;
        end
        if (strcmp(A1(i,j),'2')==1 && (i==3 || i==4))
           A(i,j)=1;
        end
        if (strcmp(A1(i,j),'3')==1 && i==3)
           A(i,j)=2;
        end
        if (strcmp(A1(i,j),'4')==1 && i==3)
           A(i,j)=3;
        end
        if (strcmp(A1(i,j),'5more')==1 && i==3)
           A(i,j)=4;
        end
        if (strcmp(A1(i,j),'4')==1 && i==4)
           A(i,j)=2;
        end
        if (strcmp(A1(i,j),'more')==1 && i==4)
           A(i,j)=3;
        end
        if (strcmp(A1(i,j),'small')==1 && i==5)
           A(i,j)=1;
        end
        if (strcmp(A1(i,j),'med')==1 && i==5)
           A(i,j)=2;
        end
        if (strcmp(A1(i,j),'big')==1 && i==5)
           A(i,j)=3;
        end
        if (strcmp(A1(i,j),'low')==1 && i==6)
           A(i,j)=1;
        end
        if (strcmp(A1(i,j),'mid')==1 && i==6)
           A(i,j)=2;
        end
        if (strcmp(A1(i,j),'high')==1 && i==6)
           A(i,j)=3;
        end
    end
end

tr=A(1:1210, :);
test=A(1211:1727, :);
output_tr=D(1:1210, :);
output_test=D(1211:1727, :);

Class=unique(output_tr);
no_class=max(size(Class));
no_feature=size(tr,2);
ns=max(size(output_test));
classes=A(:, no_feature);

K=[];
for class_number = 1:no_class
    C{class_number} = (classes==class_number) ;
    P{class_number} = sum(C{class_number})./length(C{class_number});
    K(class_number)=P{class_number};
end

for i=1:no_class
    z=strcmp(output_tr,Class(i));
    mu(i,:)=mean(xi,1);
    sigma(i,:)=std(xi,1);
end

B=[];
for i=1:ns
    F=normcdf(ones(no_class,1)*test(i,:),mu,sigma);
    B(i,:)=K.*(prod(F,2)');
end

pv=[];
[pv0, id]=max(B,[],2);
for i=1:length(id)
    pv1{i,1}=Class(id(i));
    pv(i,1)=pv1{i,1};
end

conf=sum(strcmp(pv,output_test))/length(test);
display(['accuracy = ',num2str(conf)]);
