class ExamReportsController < ApplicationController
 
  def exam_wise_report
  	@batches=Batch.all
 	  @exam_groups=Batch.first.exam_groups.all
  end

  def genrate_reports
 			
  end

  def genrate_previous_reports
  	
  end

  def select
  	@course=Course.find(params[:exam][:course_id])
  	@batches=@course.batches.all
  end

  def select_batch
    @batch=Batch.find(params[:batch_select][:id])
    @exam_groups=@batch.exam_groups.all
  end

  def generate_exam_report
    
     @exam_group=ExamGroup.find(params[:exam_group_select][:id])
     @batch=@exam_group.batch
     @student=@batch.students.last
  end

  def student_exam_report
      @exam_group=ExamGroup.find(params[:exam_group_id])
      @student=Student.find(params[:student_id])
  end

  def consolidated_report
       @exam_group=ExamGroup.find(params[:exam_group_id])
       @batch=@exam_group.batch
  end

  def subject_wise_report
    @batches=Batch.all
    @subjects=Batch.first.subjects.all
  end

   def choose_batch
    @batch=Batch.find(params[:batch_choose][:id])
    @subjects=@batch.subjects.all
  end

  def generate_subject_report  
     @subject=Subject.find(params[:subject_select][:id])
     @batch=@subject.batch
     @exam_groups=@batch.exam_groups.all
     @students=@batch.students.all
  end

  def grouped_exam_report
    @batches=Batch.all
  end

  def generate_grouped_report  
      @batch=Batch.find(params[:batch_option][:id])
      @students=@batch.students.all
      @student=@batch.students.last
      @exam_groups=@batch.exam_groups.all
      @subjects=@batch.subjects.all
  end 

  def student_report
      @batch=Batch.find(params[:batch_id])
       @exam_groups=@batch.exam_groups.all
      @student=Student.find(params[:student_id])
       @subjects=@batch.subjects.all
  end

  def archived_student_report
    @courses=Course.all
    @batches=Course.first.batches.all
  end

  def select_course
    @course=Course.find(params[:course_select][:id])
    @batches=@course.batches.all
  end

  def generate_archived_report
    
    @batch=Batch.find(params[:batch_select][:id])
    @students=@batch.archived_students.all
    @student=@batch.archived_students.last
    @exam_groups=@batch.exam_groups.all
    @subjects=@batch.subjects.all
  end

  def archived_student
      @student=ArchivedStudent.find(params[:student_id])
      @batch=@student.batch
      @exam_groups=@batch.exam_groups.all
      @subjects=@batch.subjects.all
  end

  def consolidated_archived_report
      @batch=Batch.find(params[:batch_id])
      @exam_groups=@batch.exam_groups.all
  end

  def exam_group_wise_report
     @exam_group=ExamGroup.find(params[:exam_group_option][:id])
     @batch=@exam_group.batch
  end

  def student_ranking_per_subject
    @batches=Batch.all
    @subjects=Batch.last.subjects.all
  end

  def rank_report_batch
    @batch=Batch.find(params[:rank_report][:batch_id])
    @subjects=@batch.subjects.all
  end

  def generate_ranking_report
     @subject=Subject.find(params[:rank_report][:subject_id])
     @batch=@subject.batch
     @students=@batch.students.all
     @exam_groups=@batch.exam_groups.all
  end

  def student_ranking_per_batch
    @batches=Batch.all
  end

  def generate_student_ranking_report
    @batch=Batch.find(params[:rank_report][:batch_id])
    @students=@batch.students.all
    @exam_groups=@batch.exam_groups.all
    @subjects=@batch.subjects.all
  end

  def student_ranking_per_course
    @courses=Course.all
  end

  def generate_student_ranking_report2
    @course=Course.find(params[:rank_report][:course_id])
    @batches=@course.batches.all
  end

  def student_ranking_per_school
    @courses=Course.all
    @students=Student.all
    @exam_groups=ExamGroup.all
  end

  def student_ranking_per_attendance
    @batches=Batch.all
  end

  def generate_student_ranking_report3
    @batch=Batch.find(params[:rank_report][:batch_id])
    @start_date=params[:rank_report][:start_date]
    @end_date=params[:rank_report][:end_date]
  end

  def generate_view_transcripts
     @batch=Batch.find(params[:transcript][:batch_id])
     @students=@batch.students.all
     @student=@batch.students.last
  end

  def student_view_transcripts
     @student=Student.find(params[:student_id])
     @batch=@student.batch
     @students=@batch.students.all
  end

  def select_mode
    @mode=params[:mode][:wise]
    @courses=Course.all
    @batches=Batch.all
  end

  def select_rank
    if params[:mode1]
        @mode="course"
        @course=Course.find(params[:mode1][:id])
        @batch_groups=@course.batch_groups.all
        @ranking_levels=@course.ranking_levels.all
    end
    if params[:mode2]
        @mode="batch"
        @batch=Batch.find(params[:mode2][:id])
        @ranking_levels=@batch.course.ranking_levels.all
    end  
  end
  
  def select_rank_mode
      @batch=Batch.find(params[:format])
      @rank=params[:ranking_report][:rank]
      @subjects=@batch.subjects.all
      @ranking_level=RankingLevel.find(params[:ranking_report][:ranking_level_id])
  end

  def generate_ranking_level_report
       @report_type=params[:report_type]
       @ranking_level=RankingLevel.find(params[:ranking_level_id])
       @subject=Subject.find(params[:subject][:id])
       @batch=@subject.batch
       @students=@batch.students.all
       @scores = GroupedExamReport.where(student_id: @students.collect(&:id),:batch_id=>@batch.id,:subject_id=>@subject.id)
       @batch_group=BatchGroup.find(params[:mode3][:batch_group_id]) if params[:mode3]
       @ranking_level=RankingLevel.find(params[:mode3][:ranking_level_id]) if params[:mode3]
       @mode="course"  if params[:mode3]
       @mode="batch"   if params[:mode4]
  end
end
