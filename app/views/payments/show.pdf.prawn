require 'prawn/table'

# encoding: UTF-8

  pdf.font_families.update(
    "Helvetica" => {
        :normal => "#{Prawn::BASEDIR}/data/fonts/times_new_roman.ttf",
        :bold => "#{Prawn::BASEDIR}/data/fonts/times_new_roman_bold.ttf",
    }
  )



pdf.define_grid(:columns => 6, :rows => 12)

    pdf.grid([0,0], [1,6]).bounding_box do
      pdf.text "Общество с ограниченной ответственностью Инфоком-НН", :size => 14, :style => :bold
      pdf.move_down 5
      pdf.text "г. Нижний Новгород, ул. Бекетова, 15, оф. 7"
      pdf.text "Телефон: +7 (831) 414-89-19"
    end

    pdf.grid([0,4], [1,6]).bounding_box do
      pdf.image "#{Rails.root}/public/logo.png"
    end    

    pdf.move_up 50

     one = { :content => "ИНН 5262286596 КПП 526201001", width: 350 }
     two = { :content => "Сч. №", rowspan: 2, width: 50 }
     three = { :content => "40702810329080000149", rowspan: 2, width: 130 }
     four = { :content => "<b>Получатель</b> \n\n Общество с ограниченной ответственностью 'Инфоком-НН'", width: 350 }
     five = { :content => "БИК", width: 50 }
     six = { :content => "042202824", width: 130 }
     seven = { :content => "<b>Банк получателя</b> \n\n ФИЛИАЛ 'НИЖЕГОРОДСКИЙ' ОАО 'АЛЬФА-БАНК', г. НИЖНИЙ НОВГОРОД", rowspan: 2, width: 350 }
     eight = { :content => "Сч. №", width: 50 }
     nine = { :content => "30101810200000000824", width: 130 }

  table_one = [ [one,   two,   three ],
                [four                ],
                [ seven,        five,  six ],
                [  eight, nine ] ]

    pdf.table(table_one, width: 350+50+130, :cell_style => { :inline_format => true })

pdf.move_down 20


  pdf.text "Счёт №#{@payment.id} от #{Russian::strftime(@payment.created_at, "%e %B %Y")}", :size => 20, :align => :center, :style => :bold

    pdf.grid([4,0], [5,1]).bounding_box do
      pdf.move_down 25
      pdf.text "Плательщик:"
    end

    pdf.grid([4,1], [5,5]).bounding_box do
      pdf.move_down 25
      pdf.text "#{@payment.user.calculation.name}, #{@payment.user.calculation.address}, ИНН #{@payment.user.calculation.inn}, КПП #{@payment.user.calculation.kpp}, р/сч #{@payment.user.calculation.rs}, банк #{@payment.user.calculation.bank}, кор.счет #{@payment.user.calculation.ks}, БИК #{@payment.user.calculation.bik}"
    end

     number = { :content => "№", :background_color => 'E8E8D0', :inline_format => true }
     name = { :content => "Наименование товара, работ, услуг", :background_color => 'E8E8D0' }
     amount = { :content => "Ед. изм.", :background_color => 'E8E8D0' }
     many = { :content => "Кол-во", :background_color => 'E8E8D0' }
     price = { :content => "Цена", :background_color => 'E8E8D0' }
     all = { :content => "Сумма", :background_color => 'E8E8D0' }

     table_two = [[number,   name,  amount, many, price, all ],
                  ["1", "Доступ к базе данных 'allpromoters.ru'", "шт.", "1", "#{money(@payment.amount)}", "#{money(@payment.amount)}"]]

     pdf.move_up 45
     pdf.table(table_two, width: 10+210+60+50+100+100)

