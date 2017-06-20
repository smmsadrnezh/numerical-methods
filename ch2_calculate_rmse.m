function goosale = ch2_calculate_rmse(actual_y, calculated_y)
goosale = sqrt(mean((actual_y - calculated_y).^2));
end
