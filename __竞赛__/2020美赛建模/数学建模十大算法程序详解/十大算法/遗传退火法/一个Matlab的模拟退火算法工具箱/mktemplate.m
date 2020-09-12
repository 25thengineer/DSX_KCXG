function mktemplate(problemname)
% Automated file generation supplied with SA Tools.
% Copyright (c) 2002, by Richard Frost and Frost Concepts.
% See http://www.frostconcepts.com/software for information on SA Tools.
%
% mktemplate(problemname)
%
%   problemname = name of new user directory and problem functions
%
% This function will create a directory, 'problemname' and place in it 5 m-files:
%
%       problemname_init
%       problemname_new
%       problemname_cost
%       problemname_perturb
%       try_me
%
% which comply with the satools method signatures.  The four files
%       problemname_*
% are functional, but only in the sense that X and W are null and
% the cost function returns a random number.  The mktemplate function
% is a convenience tool from which the user can fill in their particular
% problem definition.
%
% After execution, the new directory will be the users current directory.
%
if nargin ~= 1
    help mktemplate ;
    error('problemname is a required argument') ;
end
if length(problemname) < 1
    help mktemplate ;
    error('problemname was empty!') ;
end
%
newline = sprintf('\n') ;
tab = sprintf('\t') ;
%
srcpath = which('mktemplate') ;
srcdir = strrep(srcpath,'\mktemplate.m','') ;  % PC
sep = '\' ;
if strcmp(srcpath,srcdir)
    srcdir = strrep(srcpath, '/mktemplate.m','') ;  % Unix
    sep = '/' ;
    if strcmp(srcpath,srcdir)
        srcdir = strrep(srcpath, ':mktemplate.m','') ;  % Mac
        sep = ':' ;
        if strcmp(srcpath,srcdir)
            error(sprintf('Cannot decipher directory separator in path %s',srcpath)) ;
        end
    end
end
%
thisdir = pwd ;
if strcmp(thisdir,srcdir)
    disp([newline,tab,'Warning: creating in SA Tools source directory.']) ;
    disp([tab,'Directory might be lost in future software upgrade.',newline]) ;
end
%
[status, msg] = mkdir(problemname) ;
if status ~= 1
    error(msg) ;
end
cd(problemname) ;
%
srcnames = strcat(...
        {srcdir, srcdir, srcdir, srcdir, srcdir}, ...
        {sep,    sep,    sep,    sep,    sep   }, ...
        {'template_cost.txt', ...
         'template_init.txt', ...
         'template_new.txt', ...
         'template_perturb.txt', ...
         'template_try_me.txt'} ...
        ) ;
%
cvtname = strrep(problemname,' ','_') ;
while 1 ~= strcmp(cvtname,problemname) ;
    problemname = cvtname ;
    cvtname = strrep(problemname,' ','_') ;
end
problemname = cvtname ;
newnames = strcat(...
        {problemname, problemname, problemname, problemname}, ...
        {'_cost.m', '_init.m', '_new.m', '_perturb.m'} ...
        ) ;
newnames{5} = 'try_me.m' ;
%
srcstr = 'PROBLEMNAME' ;
for i=1:5
    [finp, msg] = fopen(srcnames{i},'rt') ;
    if finp == -1
        error(msg) ;
    end
    [fout, msg] = fopen(newnames{i},'wt') ;
    if fout == -1
        error(msg) ;
    end
    %
    txtline = fgets(finp) ;
    while txtline ~= -1
        txtline = strrep(txtline,srcstr,problemname) ;
        fprintf(fout,'%s',txtline) ;
        txtline = fgets(finp) ;
    end
    %
    fclose(finp) ;
    fclose(fout) ;
end
