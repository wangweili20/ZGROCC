function data = parse_dlog_bin(filename, n_channels)
%PARSE_DLOG_BIN  Parse binary data log from TMS320F28379D DLOG module.
if nargin < 2, n_channels = 8; end
fid = fopen(filename, 'rb');
raw = fread(fid, inf, 'single');
fclose(fid);
N = floor(length(raw) / n_channels);
raw = raw(1:N*n_channels);
data = reshape(raw, n_channels, N)';
end
