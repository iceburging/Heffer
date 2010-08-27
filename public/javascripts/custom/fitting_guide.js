jQuery.fn.anitaCalc = function() {
    jQuery('input.anita').click( function() {
      var A = Math.round(jQuery('input#anita_measure_a').val());
      var B = Math.round(jQuery('input#anita_measure_b').val());
      var C = B-A
      var cups = new Array('AA','AA','AA/A','A','A/B','B','B/C','C','C/D','D','D/E','E','E/F','F','F/G','G','G/H','H','H')
      if ( A>62 && A<128 && C>9 && C<29 ) {
        var chest = Math.floor((A-63)/5)*2+30;
        var cup = cups[(C-10)];
        var size = chest + cup;
      }
      else {
        var size = 'out of range';
      }
      jQuery('input#anita_result').val(size);
    });
};

jQuery.fn.royceCalc = function() {
    jQuery('input.royce').click( function() {
      var A = Math.round(jQuery('input#royce_measure_a').val()/2.54);
      var B = Math.round(jQuery('input#royce_measure_b').val()/2.54);
      var cups = new Array('AA','A','B','C','D','DD','E','F','G','H','J','K','L')
      if ( A>25 && A<41 ) {
        var chest = Math.floor((A-25)/2)*2+30;
        var C = B - chest
        if ( (chest==30 && C>-2 && C<10) | ( chest>31 && chest<37 && C>-2 && C<12 ) | ( chest>37 && chest<41 && C>-1 && C<12 ) | ( chest==42 && C>-1 && C<10 ) | ( chest==44 && C>0 && C<4 ) ) {
          var cup = cups[(C+1)];
          var size = chest + cup;
        }
        else {
          var size = 'out of range';
        }
      }
      else {
        var size = 'out of range';
      }
      jQuery('input#royce_result').val(size);
    });
};

jQuery.fn.carriwellCalc = function() {
    jQuery('input.carriwell').click( function() {
      var chest = Math.round(jQuery('input#carriwell_measure_a').val());
      var cup = jQuery('input#carriwell_measure_b').val().toUpperCase();
      var chest_array = new Array( 32,34,36,38,40,42,44);
      var cup_array = new Array( 'A','B','C','D','DD','F','G','H','I');
      if ( chest>31 && chest<45 ) {
        var chest_index = chest_array.indexOf(chest);
        var cup_index = cup_array.indexOf(cup);
        if ( cup == 'E' ) {
          var cup_index = 4
        }
        if ( cup_index>-1 ) {
            var table_a = new Array( ['S','S','S','M','M','M','L','out of range','out of range'],
                                      ['M','M','M','M','M','L','L','out of range','out of range'],
                                      ['M','M','M','L','L','L','XL','out of range','out of range'],
                                      ['L','L','L','L','L','XL','XL','out of range','out of range'],
                                      ['L','L','XL','XL','XL','XL','out of range','out of range','out of range'],
                                      ['XL','XL','XL','out of range','out of range','out of range','out of range','out of range','out of range'],
                                      ['out of range','out of range','out of range','out of range','out of range','out of range','out of range','out of range','out of range']
                                      );

            var table_b = new Array( ['S','S','S','S','M','M','M','L','out of range'],
                                      ['S','S','S','M','M','M','L','L','out of range'],
                                      ['S','M','M','M','M','L','L','XL','XL'],
                                      ['M','M','M','M','L','L','XL','XL','XL'],
                                      ['M','M','L','L','L','L','XL','XL','out of range'],
                                      ['L','L','L','L','XL','XL','XL','XL','out of range'],
                                      ['L','XL','XL','XL','XL','out of range','out of range','out of range','out of range']
                                      );
            var size_a = table_a[chest_index][cup_index];
            var size_b = table_b[chest_index][cup_index];
        }
        else {
            var size_a = 'out of range'
            var size_b = 'out of range'
        }
      }
      else {
          var size_a = 'out of range'
          var size_b = 'out of range'
      }
      jQuery('input#carriwell_result_c01').val(size_a);
      jQuery('input#carriwell_result_c02').val(size_b);
      jQuery('input#carriwell_result_c04').val(size_a);
    });
};

