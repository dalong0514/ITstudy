from urllib import robotparser

robot_parser = robotparser.RobotFileParser()

def prepare(robot_txt_url):
    robot_parser.set_url(robot_txt_url)
    robot_parser.read()

def is_allowed(target_url, user_agent='*'):
    return robot_parser.can_fetch(user_agent, target_url)

if __name__ == '__main__':
    prepare('http://www.apress.com/robots.txt')

    print(is_allowed('http://www.apress.com/covers/'))
    print(is_allowed('http://www.apress.com/gp/python'))