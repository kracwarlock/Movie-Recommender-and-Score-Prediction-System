function dataset=read_demograpgy(filename);
dataset=textscan(filename,'%u %u %s %s %s','Delimiter','|')