import java.nio.file.*;
import java.nio.file.attribute.*;
import java.util.Set;
public class FilePermissions {
    public static void main(String[] args) throws Exception {
        Path path = Paths.get("busybox");
        if (!Files.exists(path)) {
           System.err.println ("The file busybox does not exist.");
        }
        Set<PosixFilePermission> filePermissions = Files.readAttributes(path, PosixFileAttributes.class).permissions();
        filePermissions.add(PosixFilePermission.OWNER_EXECUTE);
        Files.setPosixFilePermissions(path, filePermissions);
        System.out.format("File permissions:  %s%n",  PosixFilePermissions.toString(filePermissions));
    }
}
