package example

//ExecParse exec PEG parse
func (o *Opt) ExecParse(src string) error {
	o.Buffer = src
	o.Init()
	if err := o.Parse(); err != nil {
		return err
	}
	o.Execute()
	return nil
}

//GetTmpData return map of PEG parse result
func (o *Opt) GetTmpData() *map[string][]string {
	return &o.Params
}

func (o *Opt) addParam(key, value string) {
	o.Params[key] = append(o.Params[key], value)
}
