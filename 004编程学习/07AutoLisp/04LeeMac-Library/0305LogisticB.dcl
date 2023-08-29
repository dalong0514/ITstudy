//------------------=={ Logistic Map Study }==----------------//
//                                                            //
//  logisticB.dcl to be used in conjunction with logisticB.lsp//
//------------------------------------------------------------//
//  Author: Lee Mac, Copyright © 2011 - www.lee-mac.com       //
//------------------------------------------------------------//

logistic : dialog { key = "dctitle"; spacer_1;

  : row { alignment = centered; children_alignment = centered;
  
    : image  { key = "f" ; width = 33.33; height = 15.38; fixed_width = true; fixed_height = true; color = graphics_background; }

    : slider { key = "r"; height = 15.38; fixed_height = true; layout = vertical; min_value = 0; max_value = 400; small_increment = 5; big_increment = 50; }

    : image  { key = "b";  width = 66.66; height = 15.38; fixed_width = true; fixed_height = true; color = graphics_background; }
  }
  : slider { key = "x"; width = 33.33; fixed_width = true; min_value = 0; max_value = 200; small_increment = 1; big_increment = 25; }
  spacer;
  
  : row { alignment = centered; children_alignment = centered; spacer;

    : edit_box { label = "x:"; key = "xe"; edit_width = 5; fixed_width = true; }
    : edit_box { label = "r:"; key = "re"; edit_width = 5; fixed_width = true; }
    : spacer   { width =   75; fixed_width = true; }
  }
  spacer; ok_only;
}

//------------------------------------------------------------//
//                         End of File                        //
//------------------------------------------------------------//