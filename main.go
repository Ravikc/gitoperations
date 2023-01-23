package main

import (
	"fmt"
	"os"
	"runtime"
	"time"

	git "github.com/libgit2/git2go/v33"
)

func main() {

	for {
		time.Sleep(2 * time.Second)
		repo, err := git.OpenRepository("/path/to/a/git/repo0")
		if err != nil {
			fmt.Fprintln(os.Stderr, err, runtime.GOOS, runtime.GOARCH)
			continue
		}

		if repo.IsBare() {
			fmt.Println("Yep, it's bare")
		} else {
			fmt.Println("Nope. Not a bare repo.")
		}
	}

}
