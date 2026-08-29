abstract class Aexpr {
    abstract public String fmt();
}


class CstI extends Aexpr {
    protected final int i;
    
    public CstI(int i) {
        this.i = i;
    }
    
    public String fmt() {
        return ""+i;
    }
    
    public Int getI() { return i; }
}

class Var extends Aexpr{
    protected final String name;
    
    public Var(String name) {
        this.name = name;
    }
    
    public String fmt(){
        return name;
    }
    
    public String getName() { return name; }
}

class Add extends Aexpr{
    protected final Aexpr aexpr1;
    protected final Aexpr aexpr2;
    
    public Add(Aexpr aexpr1, Aexpr aexpr2) {
        this.aexpr1 = aexpr1;
        this.aexpr2 = aexpr2;
    } 
        
    public String fmt(){
    return "(" + aexpr1.fmt() + "+" + aexpr2.fmt() + ")"
    }
}

class Sub extends Aexpr{
    protected final Aexpr aexpr1;
    protected final Aexpr aexpr2;
    
    public Sub(Aexpr aexpr1, Aexpr aexpr2) {
        this.aexpr1 = aexpr1;
        this.aexpr2 = aexpr2;
    }
            
    public String fmt(){
        return "(" + aexpr1.fmt() + "-" + aexpr2.fmt() + ")"
    }
    
}

class Mul extends Aexpr{
    protected final Aexpr aexpr1;
    protected final Aexpr aexpr2;
    
    public Mul(Aexpr aexpr1, Aexpr aexpr2) {
        this.aexpr1 = aexpr1;
        this.aexpr2 = aexpr2;
    }
            
    public String fmt(){
        return "(" + aexpr1.fmt() + "*" + aexpr2.fmt() + ")"
    }
}