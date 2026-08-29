abstract class Aexpr {
    abstract public String toString();
}


class CstI extends Aexpr {
    protected final int i;
    
    public CstI(int i) { this.i = i;}
    
    public String toString() { return ""+i; }
    public int getI() { return i; }
}

class Var extends Aexpr{
    protected final String name;
    
    public Var(String name) {this.name = name;}
    
    public String toString() {return name;}
    public String getName() {return name;}
}

abstract class Binop extends Aexpr{
    protected final Aexpr aexpr1;
    protected final Aexpr aexpr2;

    public Binop(Aexpr aexpr1, Aexpr aexpr2) {
        this.aexpr1 = aexpr1;
        this.aexpr2 = aexpr2;
    }
    
    abstract public String toString();
}

class Add extends Binop{

    public Add(Aexpr aexpr1, Aexpr aexpr2) {
        super(aexpr1, aexpr2);
    } 
        
    public String toString(){
    return "(" + aexpr1.toString() + "+" + aexpr2.toString() + ")";
    }
}


class Sub extends Binop{
    
    public Sub(Aexpr aexpr1, Aexpr aexpr2) {
        super(aexpr1, aexpr2);
    }
            
    public String toString(){
        return "(" + aexpr1.toString() + "-" + aexpr2.toString() + ")";
    }
    
}

class Mul extends Binop{
    
    public Mul(Aexpr aexpr1, Aexpr aexpr2) {
        super(aexpr1, aexpr2);
    }
            
    public String toString(){
        return "(" + aexpr1.toString() + "*" + aexpr2.toString() + ")";
    }
}

public class SimpleAexpr {
    public static void main(String[] args) {
        Aexpr aexpr = new Add(new CstI(1), new Mul(new Var("x"), new CstI(2)));
        Aexpr aexpr2 = new Add(new CstI(17), new Var("z"));

        System.out.println(aexpr.toString());
        System.out.println(aexpr2.toString());

    }
}