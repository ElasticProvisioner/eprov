package eprov

import (
    "fmt"
    "log"
    "os/exec"
    "strings"
    "syscall"
)

var (
    result = ""
)

type writer struct {
    result string
    write func(bytes []byte)
}

func (writer *writer) Write(bytes []byte) (int, error) {
    writer.result = string(bytes)
    result = string(bytes)
    return len(bytes), nil
}

func Eprov(strap string) {

    strap_split := strings.Split(strap, " ")
    cmd := exec.Command("eprov", strap_split...)

    stderr := &writer{}
    cmd.Stderr = stderr

    stdout := &writer{}
    cmd.Stdout = stdout

    if err := cmd.Start(); err != nil {
        log.Fatalf("cmd.Start: %v")
    }

    if err := cmd.Wait(); err != nil {
        if exiterr, ok := err.(*exec.ExitError); ok {
            // handling nonzero exit status using syscall package

            if status, ok := exiterr.Sys().(syscall.WaitStatus); ok {
                log.Printf("Exit Status: %d", status.ExitStatus())
            }
        } else {
            log.Fatalf("cmd.Wait: %v", err)
        }
    }

    fmt.Println(result)

}
