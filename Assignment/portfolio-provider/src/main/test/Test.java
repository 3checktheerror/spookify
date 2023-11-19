import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        String s = "123";
        StringBuilder sb = new StringBuilder(s);
        sb.setCharAt(0, '2');
        System.out.println(sb.toString());

    }
}
