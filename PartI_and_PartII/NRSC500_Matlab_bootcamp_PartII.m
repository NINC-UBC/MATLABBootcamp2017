%NRSC500 Matlab bootcamp.  Jeff LeDue, Aug 2017

%Part II: Statistics, Plotting and Resampling

%If you still have variables and commands and output around from Part I,
%you can use the commands below to clean up.

clear
clc

%clear wipes the workspace and clc cleans up the command window.

%Since most of our data is stored in files we will need to be able to read
%it in to a variable in the worksapce.  Matlab has many built in functions
%as well as wizards to help you do this for various file types, but one of 
%the simplest, most common, and direct ways to import data in text files is
%to use the load command.

%Notice in our folder we have some data stored in dat.txt.  Evaluate:

dat=load('dat.txt','-ascii');

%Matlab's load command reads the text file given in the first argument.
%The second argument simply tells load to expect text file type.  The data
%is then assigned using the = to the variable name dat.  You can see it in
%the workspace.  It is a matrix - a single row of 1550 numbers.

%%Anne's note: ASCII= american standard code for information interchange
%Encodes english alphabet(upper &lower), numbers 0-9, and punctuation into
%binary codes.

%Let's say we want to know the mean and standard deviation of our data.
%Evaluate:

the_mean=mean(dat);
the_std=std(dat);

%Mean and standard deviation are quite commonly used, but
%there are many more useful commands for interrogating matrices and their
%elements.  The doc command followed by the name of the function brings up
%the help which contains examples of how to use each one.  

%Use doc to look up how to use numel, size, sum, min and max and try each 
%one. The output of size is itself a matrix.  Assign the result of your size
%command in a variable s and index s to get the number of columns. 
%How can min and max be used to find both the min/max value as well as
%its index?  Use the index with the orginal data to confirm the value 
%returned by min and max is correct.  Compare your results with your
%neighbour to see if you are getting consistent numbers.

numel(dat)
s=size(dat)
s(2)
sum(dat)
[min_val,min_ind]=min(dat)
dat(min_ind)
[max_val,max_ind]=max(dat)
dat(max_ind)

%Recall the randn command from Part I which generates random numbers drawn
%from a standard normal distribution.  Use randn and the results of mean,
%size and std to make a matrix which has the same number of elements (and
%size) as dat, with the same mean and std, but that is normally
%distributed.  Call your new matrix norm_dat.  Hint: This can be
%accomplished by a linear transformation of of the standard normal
%distribution. y=m*x+b where m is the standard deviation and b is the
%desired mean.

norm_dat=randn(s)*the_std+the_mean;

%Once you have a candidate we will need to plot it to see if it looks
%reasonable.

%In matlab, each time you want to make a new plot or display an image you
%begin with a figure; command.  This makes a new figure window.  The
%subsequent coammnds then populate the figure window.  For example if you
%want to plot a straight line with slope 1 you could do this: 

%Evaluate:

figure;
plot(1:10);

%Recall the colon notation makes an ordered list of numbers 1 to 10 in this
%case.  You can add further commands to decorate your plot for example:

figure;
plot(1:10)
title('My first Matlab plot')

%use doc to look up the commands xlabel and ylabel.  They are analogous to
%title and can be used to provide axes labels.  Try them out below:

figure;
plot(1:10)
title('My first Matlab plot')



%There are many built in functions to help you make plots, graphs, and
%other visualizations, but the one we will use now with our normally
%distributed data is histogram.  It will make a histogram of our data
%rather than an xy plot.  use doc to look up the histogram command and
%write a command to open a new figure window and populate it with a
%histogram using the data in matrix norm_dat as input.

figure;
histogram(norm_dat)

%How does it look?  Bell shaped, mean around the expected location?  Width
%about right given the standard deviation?

%If we are really skeptical we can use the Komolgorov-Smirnov (K-S) test to
%see if the data is consistent with having come from a standard normal.
%First create a new matrix tmp which is a standardized version of norm_dat.
%ie subtract the mean and devide by the standard deviation.  Use doc kstest
%to look up the K-S statisical test.  Be sure to have it return both the
%rejection or not of the Null hypothesis as well as the p value.

tmp=(norm_dat-the_mean)/the_std;
[h,p]=kstest(tmp)

%As standardization undoes the arithmetic we did above and we started with
%standard normal, it would be very surprising to get a significant result
%here.  And we don't.

%Let's compare the histogram of our orginal data to our normal data with
%the same mean and std.  Matlab let's you plot more than one piece of data
%together on the same axes if you use the hold on command.  For example:

figure;
plot(1:10)
hold on;
plot(cos(2*pi*(1:10)/10));

%Use analogous commands with histogram to plot both distributions.

figure;
histogram(norm_dat)
hold on;
histogram(dat)

%You can see our data looks quite a bit different than the normal data. It
%is skewed to the right and has second bump around 130.

%As above, standardize our orginal data and use the KS test to see if it is
%consistent with a normal distribution.

tmp=(dat-the_mean)/the_std;
[h,p]=kstest(tmp)

%This time the p val is miniscule indicating we can reject the Null
%hypotheis that the data came from a standard normal distribution.

%At this point we know that our data does not meet one of the major
%assumptions of many stats tests - it's not normal.

%One technique that we can use that does not assume normality is called 
%Resampling. 

% NB: Matlab has some built in functions for doing resampling, bootstraping, etc
% And there are more online...  I will mention two of them at the end.  We 
%will also write some ourselves to introduce and practice writing functions.

% So what is a resample? How do we make a resample?

% Draw a sample with replacement (ie, they don't have to be unique) from the
% data.  Since our sample represents the population, a resample is another
% possible sample that could have come from the same population.  The only
% assumption here is the your sample represents the population which is
% very fundamental.  It can have any shape distribution.

%In order to do this we need to pick elements at random from dat.  This
%means random indices.  We know dat's indices range from 1 to 1550 so this
%means we need a matrix of 1550 random numbers between 1 and 1550.  
%Fortunately matlab has a built in command that will allow us to generate 
%these numbers.  This the randi command.

% example for 10 values randomly chosen from 1 to 10:

randi(10,1,10)

%Write a command using randi to generate 1550 values between 1 and 1550
%Assign these to a variable called ind (short for indices).  These will be 
%the randomly chosen elements for our resmaple.

ind=randi(1550,1,1550);

% Does your command employ numel or size? Try to use these to get the 1550
% directly from the matrix.  It's good practice and makes it easier to
% re-use the commands with data of different numbers of elements.

% So to get our resample all we need to do is index dat with ind and assign
% the result to a new variable.  Call it dat_RS.

dat_RS=dat(ind);

%Use histogram to take a look at our resample.  Compare to the orginal.  
%Unless you get a very peculiar resample it should look pretty much like the
%original one: skewed to the right, extra bump, etc.

figure;
histogram(dat_RS)

% We should probably write a function to do the resampling for us.
% Functions are very useful for encapsulating code that you will use many
% times.  Here we will do this as the resampling technique requires
% 1000's or 10,000's of resamples.  

%A quick intro to functions:  Click new and function to get matlab to give 
% you the function template.

%The first thing to do is give your function a name and save it.  Replace
%the text "untitled" (note untitled may be followed by a number if you have
%created other new functions, you will need to replace the number as well)
%with the name myfirstfunction.  Then save the file.  In matlab the name of
%a function and the file it is saved in must be the same.  The extension is
%.m just like this bootcamp file.

%Next we will want to give the function inputs and outputs.  Replace the
%text input_args with a,b leaving the parentheses in place.  Replace the
%text output_args with the_sum, the_diff, the_avg leaving the square
%brackets in place.

%Now let's add commands to the function.  These go into the template
%between the line beginning with the function and the final end which is
%connected to the top line with function by a thin black vertical line.

%Write commands to add a to b and assign the result to the_sum.  Do
%subtraction and take the mean.  Assign these to the_diff and the the_avg.
%Remember to save your function.

%Now it's time to use or call your function.  Let's define two numbers:
val1=10;
val2=5;

%These will be our two inputs.  Note that the names don't need to match the
%a and b that we used in the function definition.  These are just for the
%definition.  When the code runs the values of whichever variables are
%given as inputs will be substituted for a and b.

%Now the command for our function.  Eavluate:

[the_sum,the_diff,the_avg]=myfirstfunction(val1,val2);

%Look for your output variables in the workspace and verify that they are
%indeed the expected values.  Note that, for the outputs, I did use the same
%names as those in the function definition, but this is not required any
%valid names will work.

%Now that we have seen how to write a function, let's repeat the process to
%make a function which makes a resample. Follow these steps:

%1. Use New>function to get another template
%2. Edit the function name (untitled..) and make it make_resample
%3. Edit the input args.  Our function needs one input argument, the data.
%Call your input dat.
%4.  Edit the output args.  The function should output one matrix: the
%resampled data, call it dat_RS.
%5. Copy your 2 commands above which computed random indices ind and
%then used it to create dat_RS from dat by indexing dat with ind.  These go
%between the function at the top and the final end.
%6. Finally edit the summary to describe what your function does.

%Remember to save your function.

%Once done, evaluate:

dat_RS=make_resample(dat);
figure;
histogram(dat_RS)

%Try it several times and compare the figures.  You should see small
%differences as a result of the random resampling.

%Now that we have our function which makes it straight forward to make a
%resample we are going to want to make a lot resamples.  We can calculate
%the mean of each resample and then look at its distribution.  The width
%of this distribution is a measure of how well we know the mean and we can
%use it to estiamte a confidence interval for the mean of our data.

%In order to make lots of resamples we will need to use a matlab command
%called a for loop.  Let's introduce it with a simple example.

%a for loop always begins with a for and ends with an end.
for
end

%after the for we need to define a loop variable and a range of values for
%that varaible typically using the colon notation we saw in Part I.

for i=1:4
end

%Recall that 1:4 is shorthand for a list starting at one and counting by 1
%to 4. This means our loop will run 4 times.  On the first iteration i will
%be 1, on the second 2 and so on until the final iteration when i will be
%4.

%Commands inserted between the for and the end will be executed once per
%iteration of the loop.  Evaluate:
for i=1:4
    a=i*2
end

%You can see the four values of a being written to the command window as 
%the loop repeats 4 times.  Note that commands within a loop are usually 
%indented to make it easier to read.

%Write a for loop that calculates 4 resamples by replacing the command
%creating variable a in the example with the command using our function to
%take a resample above.

for i=1:4
    dat_RS=make_resample(dat);
end

%Note that our make_resample function doesn't print anything so it will be
%hard to tell if the loop is running.  Insert a command to compute the
%mean of the resample and store it in a variable called RS_avg.  Leave off
%the semi-colon at the end of the line so you will see the values in the
%command window below.  You should see 4 values all close to the original
%mean we calculated at the beginning of part II.

for i=1:4
    dat_RS=make_resample(dat);
    RS_avg=mean(dat_RS)
end

%Now we have only done 4 resamples so far.  We will need many more to build
%up the distribution of possible means.  Create a variable called Nresamp
%and assign it the value 2000.  Copy and paste the loop we have been
%working on below this command.  Make the upper limit of the range of
%values for the loop variable i Nresamp instead of 4.  Now the loop will
%run 2000 times!  Don't run it yet though.  We don't want to display all of
%those mean values to the screen.  4 to test the loop was ok, but 2000
%is too many.  Put a semi colon at the end of the line.  Wait!  Don't run
%it yet.  We need two more things.  First, if we were to run the loop as it
%is with each iteration RS_avg would be over written with the mean value of
%the resample generated in the current iteration.  We need to create a 
%matrix in which to store all the mean values.  Call it all_RS_avg. Look
%up the zeros command using doc to learn how to create a matrix that is a 
%single row with Nresamps columns filled with zeros.  Create this matrix
%just before the loop begins and after creating Nresamps.  Lastly within
%the loop we need to insert a command after calculation of the current
%resamples mean.  This command indexes the matrix we just created,
%all_RS_avg, with the loop variable i and assign this element the current
%resamples mean, RS_avg.  ok. Now run it.


Nresamps=2000;
all_RS_avg=zeros(1,Nresamps);
for i=1:2000;
    dat_RS=make_resample(dat);
    RS_avg=mean(dat_RS);
    all_RS_avg(i)=RS_avg;
end

%Once run we now have a matrix with 2000 mean values in it.  Use figure and
%histogram to take a look at their distribution:

figure;
histogram(all_RS_avg)

%How does it look?  Normally distributed?  This distribution is called the
%bootstrap distribution of the sample mean.

%We can get some useful information from it:
%Like the standard error of the mean using the std function:
avg_RS_se=std(all_RS_avg)

%And confidence intervals:
% My distribution looks Normal.  Then you can use critical t values.

% familiar equation stat +/- t*SE_stat for alpha=0.05;
alpha=0.05;
tcrit = tinv(1-alpha/2,1550);
disp(['Lower: ' num2str( mean(all_RS_avg)-tcrit*std(all_RS_avg) ) ])
disp(['Upper: ' num2str( mean(all_RS_avg)+tcrit*std(all_RS_avg) ) ])

%We used the above to illustrate resmapling as well as introduce you to
%plotting, functions and loops.  Matlab does have a built in function to
%calculate all_RS_avg the bootstrap distribution of the sample mean
%dierctly.  Evaluate:

all_RS_avg=bootstrp(2000,@mean,dat);

%It has 3 inputs, number of resamples, which statistic (mean in this case
%but any can be used), and the data.  Take a look at the histogram of
%all_RS_avg, should be very similar to the previous one.  There is also a
%matlab function for confidence intervals called bootci.

%These ideas can be extended to hypothesis testing as well.  This is called
%the permutation test.  It makes no assumptions about the type of
%distribution so it is very general.

%If you are interested try working through complete resampling tutorial in
%the resampling folder.  Or if you would prefer image processing try the
%VSD_example folder.