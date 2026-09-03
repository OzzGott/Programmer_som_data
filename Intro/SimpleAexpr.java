import java.util.Map;
import java.util.HashMap;

abstract class Aexpr {
    abstract public String toString();
    abstract public int eval(Map<String,Integer> env);
    abstract public Aexpr simplify();
}


class CstI extends Aexpr {
    protected final int i;
    
    public CstI(int i) { this.i = i;}
    
    public int eval(Map<String,Integer> env) {return i;}
    public String toString() { return ""+i; }
    public int getI() { return i; }
    public Aexpr simplify() { return this; }
}

class Var extends Aexpr{
    protected final String name;
    
    public Var(String name) {this.name = name;}

    public int eval(Map<String,Integer> env) {return env.get(name);}
    public String toString() {return name;}
    public String getName() {return name;}
    public Aexpr simplify() { return this; }
}

abstract class Binop extends Aexpr{
    protected final Aexpr aexpr1;
    protected final Aexpr aexpr2;

    public Binop(Aexpr aexpr1, Aexpr aexpr2) {
        this.aexpr1 = aexpr1;
        this.aexpr2 = aexpr2;
    }
    
    public int eval(Map<String,Integer> env) {
        if (this instanceof Add)
            return aexpr1.eval(env) + aexpr2.eval(env);
        else if (this instanceof Sub)
            return aexpr1.eval(env) - aexpr2.eval(env);
        else if (this instanceof Mul)
            return aexpr1.eval(env) * aexpr2.eval(env);
        else
            throw new RuntimeException("Unknown operator");
    }

    abstract public String toString();

    public Aexpr simplify() {
        Aexpr a1 = aexpr1.simplify();
        Aexpr a2 = aexpr2.simplify();
        
        if (this instanceof Add) {
            if (a1 instanceof CstI && ((CstI) a1).getI() == 0) {
                return a2.simplify();
            } else if (a2 instanceof CstI && ((CstI) a2).getI() == 0) {
                return a1.simplify();
            } else { 
                return new Add(a1, a2);
            }
        } else if (this instanceof Sub) {
            if (a2 instanceof CstI && ((CstI) a2).getI() == 0) {
                return a1.simplify();
            } else if (a1 instanceof CstI && a2 instanceof CstI && ((CstI) a1).getI() == ((CstI) a2).getI()) {
                return new CstI(0);
            } else if (a1.toString().equals(a2.toString())) {
                return new CstI(0);
            } else {
                return new Sub(a1, a2);
            }
        } else if (this instanceof Mul) {
            if (a1 instanceof CstI && ((CstI) a1).getI() == 0) {
                return new CstI(0);
            } else if (a2 instanceof CstI && ((CstI) a2).getI() == 0) {
                return new CstI(0);
            } else if (a1 instanceof CstI && ((CstI) a1).getI() == 1) {
                return a2.simplify();
            } else if (a2 instanceof CstI && ((CstI) a2).getI() == 1) {
                return a1.simplify();
            } else {
                return new Mul(a1, a2);
            }
            }
        else {
            throw new RuntimeException("Unknown operator");
        } 
    }       
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
        Map<String,Integer> env0 = new HashMap<String,Integer>();
        env0.put("a", 3);
        env0.put("c", 78);
        env0.put("baf", 666);
        env0.put("b", 111);

        System.out.println("Env: " + env0.toString());

        Aexpr aexpr = new Add(new CstI(1), new Mul(new Var("x"), new CstI(2)));
        Aexpr aexpr2 = new Add(new CstI(17), new Var("z"));
        Aexpr aexpr3 = new Add(new Mul(new CstI(18), new CstI(2)), new Var("z"));
        Aexpr aexpr4 = new Mul((new Add(new CstI(6), new Var("x"))), new Sub(new CstI(67), new CstI(42)));

        Aexpr aexpr5 = new Add(new CstI(1), new Mul(new Var("a"), new CstI(2)));
        Aexpr aexpr6 = new Sub(new Add(new CstI(1), new Var("baf")), new CstI(600));

        System.out.println(aexpr.toString());
        System.out.println(aexpr2.toString());
        System.out.println(aexpr3.toString());
        System.out.println(aexpr4.toString());

        System.out.println(aexpr5.eval(env0));
        System.out.println(aexpr6.eval(env0));
    }
}