function [ dat_RS ] = make_resample( dat )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

ind=randi(numel(dat),1,numel(dat));
dat_RS=dat(ind);

end

