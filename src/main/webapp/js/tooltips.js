//甘肃项目季度考核提示信息内容说明
// var tooltips1 ='<div class="tooltip fade bottom in" style="width:180px;right:0%;margin-right:-98px;"><div class="tooltip-arrow"></div>' +
//     '<div class="tooltip-inner">2)农产品快检室快检分 = 20 *（有效检测数量 / 季度任务数量）</div>;'
var tooltips ='<div class="tooltip fade bottom in" style="width:200px;right:70px;margin-right:-98px;margin-top: 5px;line-height: 20px;"><div class="tooltip-arrow" style="left: 90%;"></div>';
$(function () {
    $('[data-toggle="tooltip"]').hover(function() {
        var that = $(this).parent();
        //页面设置的序号，用来区分显示不同的内容：1监管机构快检室，2食用农产品快检室，3 快检车，4 检出率，5 数据质量，6 不合格处理
        var index=parseInt($(this).attr("data-index"));
        var viewType=parseInt($(this).attr("data-type"));//查看类型：1季度考核，2质量统计，3有效数据统计
        var content="";//显示的文本内容
        if(viewType==1){//viewType=1表示季度考核，根据传入的序号显示不同的说明信息
            content=initSeasonContent(index);
        }else if(viewType==2 || viewType==3){//viewType=2表示质量考核，viewType=3表示有效数据，根据传入的序号显示不同的说明信息
            content=initEffectiveContent(index);
        }/*else if(viewType==3){//3有效数据统计
            content=customEffectiveContent(index);
        }*/

        that.find('span').append(tooltips+content)
    }, function() {
        $('.tooltip').remove()
    })
});
//季度考核相关提示说明
//index： 页面设置的序号，用来区分显示不同的内容：1监管机构快检室，2食用农产品快检室，3 快检车，4 检出率，5 数据质量，6 不合格处理
function initSeasonContent(index){
    var html="";
    switch (index) {
        case 1:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>完成任务满分20分。未完成任务按完成百分比计算得数。</p>' +
                '<p><b>任务说明：</b>根据省局要求，各地市的年总任务来计算每个季度的任务数量。</p>' +
                '<p><b>上传要求：</b>仪器检测数据要求实时上传；手工试剂检测数据必须在24小时内上传，且须包含该批次检测证明照片，如：检测样品、胶体金卡或显色管等凭证，否则，将视为无效数据，不计入考核。</p>' +
                '</div>';
            break;
        case 2:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>完成任务满分20分。未完成任务按完成百分比计算得数。</p>' +
                '<p><b>任务说明：</b>根据省局要求，每个食用农产品快检室的检测任务量为360批次/季。</p>' +
                '<p><b>上传要求：</b>食用农产品快检室不得手工录入，仪器检测后实时上传检测数据，根据检测时间，逾期24小时上传的数据将视为无效数据，不计入考核。</p>' +
                '</div>';
            break;
        case 3:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>完成任务满分20分。未完成任务按完成百分比计算得数。</p>' +
                '<p><b>任务说明：</b>根据省局要求，每辆快检车每年任务总量为700批次/车，每个季度任务总量为175批次/车。</p>' +
                '<p><b>上传要求：</b>通过仪器检测的数据要求仪器实时上传；手工试剂检测数据必须在24小时内上传，且须包含该批次检测证明照片，如：检测样品、胶体金卡或显色管等凭证，否则，将视为无效数据，不计入考核。</p>' +
                '</div>';
            break;
        case 4:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>检出率满分15分，样品的检测不合格率不得低于1%，高于1%的满分；低于1%的各市州从高到低进行排名，依次递减2分，检出不合格最低的1分。未检出不合格不得分。</p></div>';
            break;
        case 5:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>数据质量满分10分，核查检测数据真实性，发现编造检测数据、记录不真实、弄虚作假等情形不得分。</p></div>';
            break;
        case 6:
            html='<div class="tooltip-inner"><p><b>得分说明：</b>不合格处置满分15分，依据系统记录和日常抽查情况，处置不规范（记录不真实；没有处置凭据图片；跟踪抽检的无法检单号）、不及时（超过3天未处置）的发现1起扣5分，扣完为止；如果检出率为0，则该项得0分。</p></div>';
            break;
        default:
            break;
    }
    return html;
}

//质量统计和有效数据统计提示信息
//index： 页面设置的序号，用来区分显示不同的内容：1监管机构快检室，2食用农产品快检室，3 快检车，4 检出率，5 数据质量，6 不合格处理
function initEffectiveContent(index){
    var html="";
    switch (index) {
        case 1:
            html='<div class="tooltip-inner"><p><b>检测室数量：</b>统计上传数据的检测室数量；</p>' +
                '<p><b>完成总数：</b>包含有效和无效数据；</p>' +
                '<p><b>有效数量：</b>按工作考核要求完成的数量；</p>' +
                '<p><b>无效数量：</b>未能按考核要求完成的数量；</p>' +
                '<p><b>考核说明：</b>仪器检测数据要求实时上传；手工试剂检测须在24小时内上传且须包含该批次检测证明凭证图片（包括检测样品和胶体金卡或显色管等）方为有效，否则，将视为无效数据。</div>';
            break;
        case 2:
            html='<div class="tooltip-inner"><p><b>检测室数量：</b>统计辖区上传数据的检测室数量；</p>' +
                '<p><b>完成总数：</b>包含有效和无效数据；</p>' +
                '<p><b>有效数量：</b>按工作考核要求完成的数量；</p>' +
                '<p><b>无效数量：</b>未能按考核要求完成的数量；</p>' +
                '<p><b>考核说明：</b>仪器检测数据要求实时上传；手工试剂检测须在24小时内上传且须包含该批次检测证明凭证图片（包括检测样品和胶体金卡或显色管等）方为有效，否则，将视为无效数据。</div>';
            break;
        case 3:
            html='<div class="tooltip-inner"><p><b>快检车数量：</b>统计上传数据的快检车数量；</p>' +
                '<p><b>完成总数：</b>包含有效和无效数据；</p>' +
                '<p><b>有效数量：</b>按工作考核要求完成的数量；</p>' +
                '<p><b>无效数量：</b>未能按考核要求完成的数量；</p>' +
                '<p><b>考核说明：</b>仪器检测数据要求实时上传；手工试剂检测须在24小时内上传且须包含该批次检测证明凭证图片（包括检测样品和胶体金卡或显色管等）方为有效，否则，将视为无效数据。</div>';
            break;
        case 4:
            html='<div class="tooltip-inner"><p><b>不合格率：</b>统计辖区内快检数据的不合格率，不合格率=有效不合格数量/有效总数。</p>' ;
            break;
        case 5:
            html='<div class="tooltip-inner"><p><b>出现次数：</b>监管人员在巡查时发现数据作假可设置为作假数据，出现作假数据的次数。</p>';
            break;
        case 6:
            html='<div class="tooltip-inner"><p><b>合规处理：</b>按考核要求完成的数量；</p>' +
                '<p><b>未处理：</b>72小时内未处理的不合格数量，此时处置还有效；</p>' +
                '<p><b>处置不当：</b>未能按考核要求完成的数量；</p>' +
                '<p><b>考核说明：</b>出现不合格检测在72小时内完成处置，否则为处置不及时；处置必须符合规范：处理记录真实；有处置过程凭据图片；送抽检的有抽检单号等，否则为处置不规范。</div>';
            break;
        default:
            break;
    }
    return html;
}
// 有效数据统计说明
function customEffectiveContent(index){
    var html="";
    switch (index) {
        case 1:
            html='<div class="tooltip-inner">实时查询每个监管机构快检室的任务完成情况，仪器检测实时上传，手工试剂需24小时内上传且须包含该批次检测证明照片，' +
                '包括检测样品和胶体金卡或显色管等凭证方为有效，否则，将视为无效数据。</div>';
            break;
        case 2:
            html='<div class="tooltip-inner">实时查询每个食用农产品快检室的任务完成情况，食用农产品快检室不得手工录入，以仪器检测实时上传为准，逾期24小时上传的数据不纳入考核。</div>';
            break;
        case 3:
            html='<div class="tooltip-inner">实时查询每辆快检车的任务完成情况，仪器检测实时上传，手工试剂需24小时内上传且须包含该批次检测证明照片，' +
                '包括检测样品和胶体金卡或显色管等凭证方为有效，否则，将视为无效数据。</div>';
            break;
        default:
            break;
    }
    return html;
}
