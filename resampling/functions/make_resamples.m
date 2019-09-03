function [ resamps_out ] = make_resamples( dat,nresamps )
%make_resamples This function resamples an input data set a specified
%number of times
% inputs:
% dat: 1xn matrix containing the data to resample.
% nresamps: the number of resamples to do.
% 
% outputs
%resamps_out: nresamps x n matrix containg the nresamps resamples of dat.
%each resample has the same numeber of data points as dat did.

% ok.  First step is to prep the output matrix, I usually use zeros for
% this.
resamps_out=zeros(nresamps,numel(dat));

% Now we can use a loop to create the resmaples using our couple lines of
% code from before.

% loop starts at one and goes to nresamps

for i=1:nresamps
    %     create indices
    ind=randi(numel(dat),1,numel(dat));
    %     use them to resample.
    dat_RS=dat(ind);
    % store in output matrix.
    resamps_out(i,:)=dat_RS;
end


end

