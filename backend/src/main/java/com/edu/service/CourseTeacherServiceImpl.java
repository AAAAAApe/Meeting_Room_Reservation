package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.edu.entity.course.CourseTeacher;
import com.edu.mapper.CourseTeacherMapper;
import com.github.jeffreyning.mybatisplus.service.MppServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 课程教师关联服务实现类
 * 处理课程与教师之间的关联关系，包括分配教师、取消分配、查询课程教师等业务逻辑
 * 继承自MppServiceImpl以支持复合主键的操作
 */
@Service
public class CourseTeacherServiceImpl extends MppServiceImpl<CourseTeacherMapper, CourseTeacher> implements CourseTeacherService {
    /**
     * 课程教师关联数据访问对象，用于操作数据库中的课程教师关联记录
     */
    private final CourseTeacherMapper courseTeacherMapper;

    /**
     * 构造函数，通过依赖注入初始化课程教师关联数据访问对象
     * @param courseTeacherMapper 课程教师关联数据访问对象
     */
    public CourseTeacherServiceImpl(CourseTeacherMapper courseTeacherMapper) {
        this.courseTeacherMapper = courseTeacherMapper;
    }

    /**
     * 为课程分配教师方法
     * 调用父类的save方法将课程教师关联信息保存到数据库
     * 
     * @param courseTeacher 课程教师关联信息对象，包含课程ID和教师ID
     * @return 分配是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean assignTeacherToCourse(CourseTeacher courseTeacher) {
        return save(courseTeacher);
    }

    /**
     * 取消教师与课程的关联方法
     * 根据课程ID和教师ID创建课程教师关联对象，然后调用父类的removeById方法删除对应的关联记录
     * 由于使用了复合主键，需要设置所有主键字段才能正确删除记录
     * 
     * @param courseId 课程ID，课程教师关联记录的主键之一
     * @param userId 教师ID，课程教师关联记录的主键之一
     * @return 取消关联是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean removeTeacherFromCourse(String courseId, String userId) {
        CourseTeacher courseTeacher = new CourseTeacher();
        courseTeacher.setCourseId(courseId);
        courseTeacher.setUserId(userId);
        return removeById(courseTeacher);
    }

    /**
     * 获取课程的所有教师方法
     * 根据课程ID查询所有与该课程关联的教师ID
     * 使用MyBatis-Plus的LambdaQueryWrapper构建查询条件，然后使用Java 8的Stream API提取教师ID
     * 
     * @param courseId 课程ID，用于筛选特定课程的教师关联记录
     * @return 返回与该课程关联的所有教师ID列表
     */
    @Override
    public List<String> getTeachersByCourse(String courseId) {
        LambdaQueryWrapper<CourseTeacher> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseTeacher::getCourseId, courseId);
        return courseTeacherMapper.selectList(queryWrapper)
                .stream()
                .map(CourseTeacher::getUserId)
                .collect(Collectors.toList());
    }

    /**
     * 获取教师教授的所有课程方法
     * 根据教师ID查询所有与该教师关联的课程ID
     * 使用MyBatis-Plus的LambdaQueryWrapper构建查询条件，然后使用Java 8的Stream API提取课程ID
     * 
     * @param userId 教师ID，用于筛选特定教师的课程关联记录
     * @return 返回与该教师关联的所有课程ID列表
     */
    @Override
    public List<String> getCoursesByTeacher(String userId) {
        LambdaQueryWrapper<CourseTeacher> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseTeacher::getUserId, userId);
        return courseTeacherMapper.selectList(queryWrapper)
                .stream()
                .map(CourseTeacher::getCourseId)
                .collect(Collectors.toList());
    }
}