%%
% Name: Ritu Kumari     Roll No.: 2016078
filename='lenses.data.txt';
G=readtable(filename);
A=table2array(G(:, 2:5));
D=table2array(G(:, 6));

tr=A(1:17, :);
test=A(17:24, :);
output_tr=D(1:17, 1);
output_test=D(17:24, 1);

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
    z=(output_tr==Class(i));
    xi=tr(z, :);
    mu(i,:)=mean(xi,1);
    sigma(i,:)=std(xi,1);
end

B=[];
for i=1:ns
    F=normcdf(ones(no_class,1)*test(i,:),mu,sigma);
    display(F);
    B(i,:)=K.*(prod(F,2)');
end

pv=[];
[pv0, id]=max(B,[],2);
for i=1:length(id)
    pv1{i,1}=Class(id(i));
    pv(i,1)=pv1{i,1};
end

conf=sum((pv==output_test))/length(test);
display(['accuracy = ',num2str(conf)]);
