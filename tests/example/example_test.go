package example

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestParse(t *testing.T) {
	o := &Opt{
		Params: map[string][]string{},
	}
	err := o.ExecParse("test.localhost:8888/path")
	assert.NoError(t, err)
	data := *o.GetTmpData()
	assert.Equal(t, "test", data["userkey"][0])
	assert.Equal(t, "path", data["userpath"][0])
	fmt.Print(data)

	err = o.ExecParse("test.invalidhost:aaaa")
	assert.Error(t, err)

}