%% Problem 2

init_B = 0; % initial copy numbers of ghrelin at Junction B
init_C = 0; % initial copy numbers of ghrelin at Junction C
init_D = 0; % initial copy numbers of ghrelin at Junction D
init_E = 0; % initial copy numbers of ghrelin at Junction E
init_F = 0; % initial copy numbers of ghrelin at Junction F
init_G = 0; % initial copy numbers of ghrelin at Junction G
init_H = 0; % initial copy numbers of ghrelin at Junction H
init_I = 0; % initial copy numbers of ghrelin at Junction I
init_J = 0; % initial copy numbers of ghrelin at Junction J
init_K = 0; % initial copy numbers of ghrelin at Junction K
init_L = 0; % initial copy numbers of ghrelin at Junction L
other = 0; % initial copy numbers of ghrelin at other arteries that eventually recirculate to the heart
t_max = 24;

species = [init_B init_C init_D init_E init_F init_G init_H init_I init_J init_K init_L other];
rxn_matrix = [-1 1 0 0 0 0 0 0 0 0; 1 -1 0 0 0 0 0 0 0 0; -1 0 1 0 0 0 0 0 0 0;
    0 0 -1 1 0 0 0 0 0 0; 0 0 -1 0 1 0 0 0 0 0; 0 0 0 0 -1 1 0 0 0 0; 0 0 0 0 -1 0 1 0 0 0;
    0 0 0 0 -1 0 0 1 0 0; 0 0 0 0 -1 0 0 0 1 0; 0 0 0 0 -1 0 0 0 0 1; 1 0 0 0 0 -1 0 0 0 0;
    1 0 0 0 0 0 -1 0 0 0; 1 0 0 0 0 0 0 -1 0 0; 1 0 0 0 0 0 0 0 -1 0; 1 0 0 0 0 0 0 0 0 -1;
    0 0 0 0 0 1 0 0 0 0; 1 0 0 0 -1 0 0 0 0 0];
prob = [0 1 1 0 0 0 0 0 0 0; 1 0 0 0 0 0 0 0 0 0; 0 0 0 1 1 0 0 0 0 0;
    1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 1 1 1 1; 1 0 0 0 0 0 0 0 0 0; 1 0 0 0 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0 0 0; 1 0 0 0 0 0 0 0 0 0; 1	0 0 0 0 0 0 0 0 0];

rng(3)
t_data = [0];
data = [1];
    
while t_data(end) < t_max        
    tau = 0.05;
    
        
    temp = zeros(1, 10);
    if species(1) > 0 % Starts making decisions w hormone in heart
        for j = 1:species(1)
            r = rand;
            prob_raw = prob(1,:);
            prob_raw = prob_raw(prob_raw > 0);
            dist = cumsum(prob_raw) / sum(prob_raw);
            
            if 0 <= r && r <= dist(1) % probability if hormone will go to lung
                temp = temp + rxn_matrix(1,:);
            else % probability if hormone will go to aorta
                temp = temp + rxn_matrix(3,:);
            end    
         end
     end
        
     if species(2) > 0 % Makes decision w hormone in lung
         for j = 1:species(2)
             temp = temp + rxn_matrix(2,:); % hormone in lung will always recirculate back to heart
         end
     end
        
     if species(3) > 0 % Makes decision w  hormone in aorta
         for j = 1:species(3)
             r = rand;
             prob_raw = prob(3,:);
             prob_raw = prob_raw(prob_raw > 0);
             dist = cumsum(prob_raw) / sum(prob_raw);
            
             if 0 <= r && r <= dist(1) % probability if hormone will go to head
                 temp = temp + rxn_matrix(4,:);
             else % probability if hormone will go to descending aorta
                 temp = temp + rxn_matrix(5,:);
             end
         end
      end
        
      %if species(4) > 0 % Makes decision w hormone in head
         %for j = 1:species(4)
             %temp = temp + rxn_matrix(17,:); % hormone will recirculate back to heart
         %end
      %end
        
      if species(5) > 0 % Makes decision w hormone in descending aorta
         for j = 1:species(5)
             r = rand;
             prob_raw = prob(5,:);
             prob_raw = prob_raw(prob_raw > 0);
             dist = cumsum(prob_raw) / sum(prob_raw);
               
             if 0 <= r && r <= dist(1) % probability if hormone will go to liver
                 temp = temp + rxn_matrix(6,:);
             elseif dist(1) <= r && r <= dist(2) % probability if hormone will go to kidney
                 temp = temp + rxn_matrix(7,:);
             elseif dist(2) <= r && r <= dist(3) % probability if hormone will go to muscle
                 temp = temp + rxn_matrix(8,:);
             elseif dist(3) <= r && r <= dist(4) % probability if hormone will go to urogenital
                 temp = temp + rxn_matrix(9,:);
             elseif dist(4) <= r && r <= dist(5) % probability if hormone will go to leg
                 temp = temp + rxn_matrix(10,:);
             end
         end
      end
        
        
      if species(6) > 0 % Makes decision w hormone in liver
         for j = 1:species(6)
              temp = temp + rxn_matrix(11,:); % hormone will recirculate back to heart           end
         end
      end
        
      if species(7) > 0 % Makes decision w hormone in kidney
         for j = 1:species(7)
              temp = temp + rxn_matrix(12,:); % hormone will recirculate back to heart
         end
         temp = temp + rxn_matrix(16,:); % production rate of hormone
      end
        
      if species(8) > 0 % Makes decision w hormone in muscle
         for j = 1:species(8)
              temp = temp + rxn_matrix(13,:); % hormone will recirculate back to heart
         end
      end
        
      if species(9) > 0 % Makes decision w hormone in urogenital
          for j = 1:species(9)
              temp = temp + rxn_matrix(14,:); % hormone will recirculate back to heart
          end
      end  
        
      if species(10) > 0 % Makes decision w hormone in leg
          for j = 1:species(10)
              temp = temp + rxn_matrix(15,:); % hormone will recirculate back to heart
          end
      end
    
      t_data(end+1) = t_data(end) + tau;
      species = species + temp;
      data(end+1) = species(4);
end
    
    
fig2g = figure(1);
plot(t_data,data,'r','DisplayName', 'Activator');
title('Accumulation of hormone')
xlabel('Time Units')
ylabel('Species Copy Number')
legend