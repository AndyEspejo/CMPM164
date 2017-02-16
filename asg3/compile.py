import yaml
import sys

if len(sys.argv) is not 2:
    print "usage: %s story.yaml" % sys.argv[0]
    sys.exit(1)

with open(sys.argv[1]) as f:
    story = yaml.load(f.read().lower())

print "{"

print "\t_title=[[%s]]," % story['_title']
print "\t_subtitle=[[%s]]," % story['_subtitle']

for label, steps in story.items():

    if label.startswith('_'):
        continue
    
    print "\t[ [[%s]] ]={" % label
    
    for step in steps:
        
        if 'do' in step: print "\t\t{type='do',code=function() %s end}," % step['do']
        if 'write' in step:
            if type(step['write']) is str:
                step['write'] = [step['write']]
            for line in step['write']:
                print "\t\t{type='write',line=[[%s]]}," % line
        if 'write-expr' in step: print "\t\t{type='write-expr',expr=function() return %s end}," % step['write-expr']
        if 'goto' in step: print "\t\t{type='goto',label=[[%s]]}," % step['goto']
        if 'if' in step: print "\t\t{type='ite',['if']=function() return %s end,['then']=[[%s]],['else']=[[%s]]}," % (step['if'],step['then'],step['else'])
        if 'options' in step:
            print "\t\t{type='choice',options={"
            for text, label in step['options'].items():
                print "\t\t\t{text=[[%s]],label=[[%s]]}," % (text, label)
            print "\t\t}}, -- options"
    
        print "\t\t{type='pause'},"
    
    print "\t}, -- %s" % label

print "}"
