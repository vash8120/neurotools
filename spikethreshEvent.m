function [position,isterminal,direction] = spikethreshEvent(t,y,pars)
  position = y(1)-30; % The value that we want to be zero
  isterminal = 1;  % Halt integration 
  direction = 1;   % The zero can be approached from either direction
end
