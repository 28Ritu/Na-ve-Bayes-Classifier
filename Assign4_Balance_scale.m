%%
% Name: Ritu Kumari     Roll No.: 2016078
filename='balance-scale.data.txt';
G=readtable(filename, 'Delimiter',',');
A=table2array(G(:, 2:5));
D=table2array(G(:, 1));

tr=A(1:438, :);
test=A(439:625, :);
output_tr=D(1:438, 1);
output_test=D(439:625, 1);

Class=unique(output_tr);
no_class=max(size(Class));
no_feature=size(tr,2);
ns=max(size(output_test));
classes=A(:, no_feature);
K=[];
for class_number = 1:no_class
    C{class_number} = (classes == class_number);
    P{class_number} = sum(C{class_number})./length(C{class_number});
    K(class_number)=P{class_number};
end

for i=1:no_class
    z=strcmp(output_tr,Class(i));
    xi=tr(z, :);
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
    pv{i,1}=Class(id(i));
    pv(i)=pv{i,1};
end

conf=sum(strcmp(pv,output_test))/length(test);
display(['accuracy = ',num2str(conf)]);
