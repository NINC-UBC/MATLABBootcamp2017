%NRSC500 Matlab bootcamp.  Jeff LeDue, Aug 2017

%First setup the interface in 3 column mode and add command history docked
%in the lower right part of the screen so everyone is on the same page.

%Explain the interface.  Main elements.
%Current folder on the left, for folder/file navigation
%Editor window in the center.  This is where you write and run your code.
%Command Window directly below the editor. Type commands here to run them.
%Workspace to the right.  Allows you to interact with variables in memory.
%Command History.  Logs what you run in the command window so you can
%re-use it.

%Comment on comments: In matlab anything beginning with a % is ignored if
%you run the program.  These are referred to as comments.  They allow you
%to write messages to yourself and other potential users to explain what is
%going on.  I will use them throughout the boot camp to expalin what to do.

%Let's begin.

%Part I: Intro to Matlab, Matrices, & Indexing

%Click in the command window below.  You should see the cursor blink at the
%prompt >>.  Type 1+1 and press enter.  When you press enter, matlab
%evaulates the arithmetic and displays the result.  Since we did not assign
%the result to a variable, matlab assigns the answer to the default
%variable name ans.  Look in the workspace you will see the variable name
%and its value.

%Now highlight the line below with the mouse and right click.  Press
%evaulate selection.

1+2

%Notice the 1+2 has appeared in the command window below.  Using the mouse
%we can highlight command(s) and evaluate.  Matlab runs them exactly as if
%we had typed each line in the command window and pressed enter.  Notice in
%the workspace the value of ans has been updated to 3 as well.

%Matlab allows us to store the results of our commands in variables.  This
%is called assignment and uses the = symbol.  Highlight the commands below
%and right click and press evaluate.

a=1+3
b=a+7
c=a+b
d=log(c)
e='hello, world'

%Nice, we have assigned 5 variables!  A few things to note: 
%1. Variable names can be anything.  I used single letters here, but 
%usually we try to give them a name which reminds us of their purpose while
%steering clear of names of matlab functions.
%2. Matlab has many built in functions, like the log used in d.
%3. Variables can be of different types.  Notice e is letters.  These are 
%called strings and denoted by the single quotes.  
%4. Even numerical data types are distinct.  a,b & c are whole numbers while
%d has values past the decimal point.  Values like d are called floating 
%point or real while a, b & c are integers.

%%Anne's notes: What is double? Double precision floating point
% Floating point: a number's radix point (decimal point in base 10 system, binary point in base 2)
% It is called this way because the radix point can "float"(to be place anywhere in the significant digit)
% example: 123.45= 1.2345*10^2 or 12345*10^-2. -> similar idea of some sort
% of scientific notation
% this system is useful to represent numbers of different magnitude with
% same fixed length of digit
%Half, single and double
% Half=binary16= 3.3 decimal places. Single=binary 32= 7.2 decimal places. Double=binary 64= 15.9 decimal places.
% What's the difference? ->Details, resolution and computing power required! 
% These terms reflect decimal points(in base2) that the value carries
% IEEE standardization of binary64
% sign bit:1, exponent bit: 13, fraction bit: 52
% More info: wikipedia float-point arithmatics

%Introducing the matrix.  The matrix is the perhaps the most useful data
%structure in matlab.  It is made up of a collection of elements of
%numerical data.  Let's create one using one of matlab's built in
%functions.  The command randn gives you numbers chosen randomly from a
%standard normal distribution (mean = 0 and std =1).  Evaluate this
%command:

myvar=randn(1)

%Try it again.  You will get different values each time.  Now evaluate:

mymat=randn(9)

%You can see that you get a lot of numbers.  9 rows and 9 colums worth.
%When given a single input argument N the matlab function randn returns a
%matrix with NxN rows by columns.  Sometimes we don't want to see so much
%output in the command window.  Evaluate:

mymat=randn(9);

%Putting a semi colon ; at the end of a command suppresses the output in
%the command window, but nonetheless the variable is updated with new
%values.  Locate the variable mymat in the workspace.  Note that where
%there was a single value for our variables a, b & c  our variable mymat 
%says 9x9 double.  9x9 indicates that this is a matrix with 9 rows and 9 
%columns and that the datatype is double.  Double is floating point or real
%decimal value number with a certain number of digits after the decimal place.
%Double click the variable name mymat to see the values.  You will get an
%additional variables tab in the editor window with an excel like view of
%the values in the rows and columns of the variable mymat.  If you double
%click one of the elements you can directly edit its value.  Go ahead and
%try.  Find the 5th row and 6th column and edit the value to be 47.

%Let's take a minute to think about the types of data we could store in a
%matrix.

%What if we had the time course of a signal?  We would need a matrix with a
%single row (or col).  Such a 1-d matrix could store the value of our
%signal at each timepoint.  This could be an EEG recording for example.

%What if we had an image? Such as a fluoresence microscopy image or IHC
%stained tissue?  This would require a 2d matrix where each element in the 
%rows and columns stored the instensity of the fluorescence at that
%location in the image.

%What if we had a time series of images?  Such as two-photon Ca2+ activity
%in cells?  This would be a 3d matrix.  Like the image, the rows and columns
% would store intesnity at that position in the image, and a 3rd dimension
% would keep track of the time points.

%What if we had 2 color 2p photon time lapse imaging?  Say we imaged Ca2+
%actvity with a red genetically encoded probe and extracellular glutamate
%with  a green probe.  Then we could use a 4d matrix, 1 dim for color, 2
%for xy location, and a fourth for time.

%Can you think of other types of data you could represent using matrices?
%What would you need for:

%xyz image stack obtained on a confocal microscope?
%a 16 channel silicon probe for e-phys experiments?
%fMRI recordings?

%Hopefully you are convinced that matrices have a lot of potential uses to
%represent neuroscience data.  

%If we use matrices to store our data, it becomes necessary to isolate
%portions of the data for our analyses.  This is called basic indexing.
%For example, say we wanted to know the value of the element in the first
%row and first column of mymat.  We would write:

mymat(1,1)

%The variable name of the matrix is followed by parentheses ().  Within the
%parentheses are the indices.  These are comma separated.  Rows preceed
%columns.  Rows then columns, race car.

%Use indexing to check the value of the 5th row and 6th column of mymat.
%Is it what you expect to see?

%Suppose we want to isolate matrix elements in the neighbourhood of element
%(5,6).  This could be an image region of interest (ROI) for example.
%Matlab has an important and frequently used shorthand for generating
%ordered lists which can then be used as indices. Say we wanted a 5x5
%element region centered at element (5,6).  We could need rows 3,4,5,6,7
%and columnds 4,5,6,7,8. This can be accomplished using the :. For example
%evaluate the following command.

1:9

%The colon generates an ordered list, starting at the first value and
%ending at the second value.  start:finish.  The default increment is 1
%which is perfect for indices as these can only be postive integer values.

%write commands to generate the ordered lists we need to isolate the rows
%and cols discussed above.

%index the matrix mymat using your : notation for ordered lists to isolate
%the 5x5 group of elements centered at 5,6

%Does it look as you expect?  Do you see 47 in the center of the grouping?

%In other circumstances you may want to isolate elements that satisfy a
%condition.  Continuing the analogy to images stored in 2d matrices, an
%example would be an intensity threshold.  Conditions comparing values can
%be made using the relational operators > greater than, < less than,
% >= greater than or equal to, <= less than or equal to, == is equal to,
% and ~= is not equal to.

%If we are thinking of an intensity threshold we would want to know what
%pixels (elements) have values greater than our threshold.  Say our threshold
%was 25.  Evaluate:

mymat>25

%This returns a matrix full of ones and zeros.  Likely you will see only a
%single 1 in row 5 col 6 where we had our value of 47.  Evaluate:

logical_ind=mymat>25;

%With this command we assign the result to a new variable called
%logical_ind.  Look for it in the workspace.  It is a 9x9 matrix but the
%data type is no longer decimal valued numbers.  It is called logical.
%This means it only has two states, 1 or 0, True or False, Passed the
%condition or did not.

%Finally we can use our matrix logical_ind to index mymat.  This is called
%logical indexing.  In other words, instead of finding the values of ?mymat?
%based on row and column inputs, we find the values of ?mymat? based on 
%where ?logical_ind? is 1. This is called logical indexing. Evaluate:

mymat(logical_ind)

%The syntax is similar to basic indexing in that the index is given in 
%parentheses after the variable name, but this time only values where the
%logical index is True (1) are returned.

%Adjust the threshold until you get more than one value returned by the
%logical indexing of mymat.  Hint- modify the previous logical_ind variable
%by varying the threshold.

mymat(mymat>3.5)

%Ok, time to move on and use matrices to illustrate some ideas from
%Statistics.