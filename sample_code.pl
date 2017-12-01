use List::Util qw/sum/;

chomp(my $line_1 = <STDIN>);
my @my_card = split(" ", $line_1);

if($my_card[0] eq 0){
    print "0"; # 賭けチップ数

}else{
    if(sum(@my_card) < 10){ # ★カードを引く条件の合計値を変えてみよう！★
        print "HIT";# カード引く
    }else{
        print "STAND";# 勝負する
    }
}
