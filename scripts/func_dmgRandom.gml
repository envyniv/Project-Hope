//choose amount of damage to deal
//var range = >n1&&<n2 //range(n1,n2)
var choosedmg = irandom(100)

if (choosedmg >= 25) && (choosedmg <= 85) {  //if choosedmg is more than 25 and less than 85
    damage = irandom_range(5,8);
    } else {
        if (choosedmg < 25) && (choosedmg >= 0) {  //if choosedmg is less than 25 but more than 0
        damage = irandom_range(1,4);
        } else {
          if (choosedmg > 85) && (choosedmg <= 100) {
          damage = irandom_range(10,25);
          }
       }
    }
    
//remember to read how you spelled vars, you fuck.
//and if you become fucking blind from masturbating too much just CRTL+F the variable you're unsure you misspelled correctly

