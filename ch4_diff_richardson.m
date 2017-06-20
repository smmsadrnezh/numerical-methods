function goosfand = ch4_diff_richardson(f, x, deg, oh, h, mantissa)

goosfand = (4*(ch4_diff_main(f, x, deg, oh, (h./2), mantissa)) - ch4_diff_main(f, x, deg, oh, h, mantissa))/((2.^2)-1);

end